# Raftar Gaddi – Backend Engineering Audit
# Document 10: BullMQ & Asynchronous Background Worker Audit

**Audit Date:** November 2026  
**Auditor:** Senior DevOps & Backend Systems Engineer  
**Component:** BullMQ Queues, Job Processors, Worker Segregation, and Dead-Letter Queue (DLQ) Architecture

---

## 1. Background Processing Topology

Asynchronous job processing in Raftar Gaddi is managed by **BullMQ** via `@nestjs/bullmq` in [`src/jobs/jobs.module.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/jobs/jobs.module.ts).

The system registers 6 distinct queues in [`src/jobs/constants.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/jobs/constants.ts):
```typescript
export const QUEUE_NAMES = {
  NOTIFICATION: 'notification-queue',
  EMAIL: 'email-queue',
  SMS: 'sms-queue',
  INVOICE: 'invoice-queue',
  ANALYTICS: 'analytics-queue',
  CLEANUP: 'cleanup-queue',
};
```

---

## 2. Critical Background Processing Deficiencies

### 2.1 Process Co-Location: Background Workers Running Inside the HTTP API Server
In [`src/app.module.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/app.module.ts#L123), `JobsModule` is directly imported into the root `AppModule`:
```typescript
// src/app.module.ts: Line 123
JobsModule,
```
And in [`src/jobs/jobs.module.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/jobs/jobs.module.ts#L31):
```typescript
// src/jobs/jobs.module.ts: Line 31
providers: [NotificationProcessor, EmailProcessor, InvoiceProcessor, CleanupProcessor],
```

#### Why This Breaks Production Microservice Boundaries:
1. When `main.ts` bootstraps `AppModule`, NestJS instantiates all four `@Processor()` worker hosts **inside the primary HTTP API server process**.
2. When the standalone worker (`src/jobs/worker.ts`) bootstraps `AppModule`, it also instantiates all four processors.
3. **Severe Operational Consequences:**
   - **Event Loop Starvation:** Heavy CPU tasks (e.g. PDF generation, data compression, image resizing) executed by `InvoiceProcessor` run inside the HTTP server's event loop, creating latency spikes for API and WebSocket requests.
   - **Queue Contention:** Both the API containers and Worker containers pull jobs from the same Redis queues simultaneously. If an operator scales the API to 10 instances, 10 API instances start processing background jobs, stealing memory and CPU allocated for web traffic.
4. **Remediation:** Split `JobsModule` into two modules:
   - `JobsQueueModule`: Exports only `BullModule.registerQueue(...)` for queue producers (used by HTTP API).
   - `JobsWorkerModule`: Contains all `@Processor()` worker consumers (used ONLY by `worker.ts`).

---

### 2.2 Mock Processor Implementations & Phantom Queues
Inspection of the actual processor implementations revealed that **the background processors are non-functional simulations**:

1. **`CleanupProcessor` ([`src/jobs/processors/cleanup.processor.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/jobs/processors/cleanup.processor.ts#L17)):**
   ```typescript
   // Mock delay only - does NOT perform any cleanup!
   this.logger.log(`Executing cleanup tasks...`);
   await this.delay(1000);
   this.logger.log(`Cleanup completed successfully`);
   ```
   *Reality:* It does NOT purge expired OTPs, does NOT clean expired idempotency keys, does NOT delete stale refresh tokens, and does NOT prune old `booking_locations`!
2. **`InvoiceProcessor` ([`src/jobs/processors/invoice.processor.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/jobs/processors/invoice.processor.ts#L18)):**
   ```typescript
   // Mock delay only - does NOT generate any PDF!
   await this.delay(500);
   ```
   *Reality:* No PDF rendering engine (Puppeteer, PDFKit) is connected, and no S3/GCS bucket upload exists.
3. **Phantom Queues (`SMS` and `ANALYTICS`):**
   - In [`src/jobs/jobs.module.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/jobs/jobs.module.ts#L25, #L27), `QUEUE_NAMES.SMS` and `QUEUE_NAMES.ANALYTICS` are registered with BullMQ.
   - **Zero processor classes exist for these queues.** Any job pushed to `sms-queue` or `analytics-queue` sits in Redis forever without ever being processed.

---

### 2.3 Missing Job Retention Limits (Redis OOM Time Bomb)
In [`src/jobs/jobs.module.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/jobs/jobs.module.ts#L22-L29):
```typescript
BullModule.registerQueue(
  { name: QUEUE_NAMES.NOTIFICATION },
  { name: QUEUE_NAMES.EMAIL },
  { name: QUEUE_NAMES.SMS },
  { name: QUEUE_NAMES.INVOICE },
  { name: QUEUE_NAMES.ANALYTICS },
  { name: QUEUE_NAMES.CLEANUP },
)
```

#### Defect:
- No `defaultJobOptions` are configured.
- BullMQ by default **keeps completed and failed jobs in Redis memory indefinitely** unless explicitly told to remove them.
- In production, after running 500,000 notifications and invoice jobs, millions of completed job keys accumulate in Redis, consuming gigabytes of memory until Redis crashes with OOM.
- **Remediation:** Enforce job retention limits on all queues:
  ```typescript
  defaultJobOptions: {
    removeOnComplete: { count: 100, age: 3600 },
    removeOnFail: { count: 500, age: 86400 * 7 },
    attempts: 3,
    backoff: {
      type: 'exponential',
      delay: 2000,
    },
  }
  ```

---

## 3. Summary of BullMQ Worker Deficiencies

| Feature | Current State | Risk | Required Fix |
|---|---|---|---|
| **Worker Isolation** | Co-located in HTTP API process | 🔴 Critical | Separate `JobsWorkerModule` from `AppModule`. |
| **Cleanup Worker** | Dummy `delay(1000)` mock | 🔴 High | Implement actual SQL/Redis cleanup queries. |
| **Invoice Worker** | Dummy `delay(500)` mock | 🔴 High | Integrate PDF generation and cloud storage. |
| **SMS Queue** | Registered with NO processor | 🔴 High | Implement `SmsProcessor` or remove queue. |
| **Memory Cleanup** | Unbounded job retention in Redis | 🔴 Critical | Set `removeOnComplete` and `removeOnFail`. |
| **Dead-Letter Queue** | None (Silent job abandonment) | ⚠️ High | Add DLQ queue and Sentry failure alerting. |
