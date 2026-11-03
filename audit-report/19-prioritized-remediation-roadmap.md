# Raftar Gaddi – Backend Engineering Audit
# Document 19: Prioritized Technical Remediation Roadmap

**Audit Date:** November 2026  
**Auditor:** Principal Software Architect & Engineering Director  
**Component:** Phased Engineering Action Plan, Implementation Guides, Effort Estimates, and Verification Criteria

---

## 1. Remediation Strategy Overview

To transition the Raftar Gaddi backend from its current **34/100 (Critical Risk)** state to an **enterprise-ready production standard (> 90/100)**, remediation must be executed across **four structured, non-overlapping phases**:

```
PHASE 1: Immediate Critical Fixes (Day 1 – 3)
         → Eliminate Auth Bypasses, Real-Time PII Leaks, Race Conditions, and Payment Fraud.

PHASE 2: Core Engineering & Data Integrity (Week 1 – 2)
         → Decimal Migration, Middleware Registration, Redis IO Adapter, and Dispatch Engine.

PHASE 3: Infrastructure, Workers & I/O Optimization (Week 3 – 4)
         → BullMQ Segregation, GPS Stream Buffering, Docker Hardening, and Observability.

PHASE 4: Production Hardening, Compliance & Scale (Week 5 – 6)
         → UIDAI Aadhaar Vault, PostGIS Polygons, Automated E2E Suite, and k6 Load Tests.
```

---

## 2. Phase 1: Immediate Critical Fixes (Day 1 – Day 3)
**Objective:** Close all remote backdoors, prevent financial double-spending, eliminate public PII leaks, and resolve race conditions.

### 1.1 Purge Dev Auth Bypasses & Static Demo Tokens
- **Target File:** [`src/common/guards/jwt-auth.guard.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/common/guards/jwt-auth.guard.ts)
- **Action:** Delete lines 39–61 (auto-provisioning dev users) and lines 71–91 (`demo_admin_jwt_token_123` bypass).
- **Implementation:**
  ```typescript
  // Replace lines 38-63 with strict token requirement:
  if (!token) {
    throw new UnauthorizedException('Access token is required');
  }

  // Replace lines 65-93 with standard verification:
  try {
    const payload = await this.jwtService.verifyAsync<JwtPayload>(token, {
      secret: this.configService.jwtAccessSecret,
    });
    request.user = payload;
  } catch (error) {
    throw new UnauthorizedException('Invalid or expired access token');
  }
  return true;
  ```
- **Acceptance Criteria:** `curl -X GET https://api/v1/admin/overview` with no token returns HTTP 401; with token `'demo_admin_jwt_token_123'` returns HTTP 401.

---

### 1.2 Remove WebSocket Unsigned JWT Decode Fallback
- **Target File:** [`src/modules/locations/gateways/location.gateway.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/locations/gateways/location.gateway.ts)
- **Action:** Delete `this.jwtService.decode(token)` in `handleConnection` (lines 51–56).
- **Implementation:**
  ```typescript
  let payload: JwtPayload;
  try {
    payload = this.jwtService.verify<JwtPayload>(token, {
      secret: this.configService.jwtAccessSecret,
    });
  } catch (err) {
    this.logger.warn(`Client ${client.id} rejected: Invalid token signature`);
    client.disconnect();
    return;
  }
  ```

---

### 1.3 Eliminate Global Real-Time PII Broadcasting
- **Target File:** [`src/modules/locations/gateways/location.gateway.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/locations/gateways/location.gateway.ts)
- **Action:** Delete all `this.server.emit(...)` calls on lines 402, 413, 424, 448. Restrict all event emissions to authorized rooms:
  ```typescript
  // In handleBookingStatus:
  this.sendToBookingRoom(payload.bookingId, 'booking:status', payload);
  // REMOVE: this.server.emit('booking:status', payload);

  // In handleBookingCancelled:
  this.sendToBookingRoom(payload.bookingId, 'booking:status', { bookingId: payload.bookingId, status: 'CANCELLED' });
  // REMOVE: this.server.emit('booking:cancelled', payload);
  ```

---

### 1.4 Cryptographic HMAC Webhook Signature Verification
- **Target File:** [`src/modules/payments/services/payments.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/payments/services/payments.service.ts)
- **Action:** Replace `payload.signature !== 'valid-signature'` with timing-safe HMAC-SHA256 signature verification:
  ```typescript
  import * as crypto from 'crypto';

  const expectedSignature = crypto
    .createHmac('sha256', this.configService.get('PAYMENT_WEBHOOK_SECRET'))
    .update(`${payload.orderId}|${payload.transactionId}`)
    .digest('hex');

  const isValid = crypto.timingSafeEqual(
    Buffer.from(payload.signature || ''),
    Buffer.from(expectedSignature),
  );

  if (!isValid) {
    throw new AppException('BAD_REQUEST', 'Invalid webhook signature', 400);
  }
  ```

---

### 1.5 Atomic Booking Acceptance (Compare-And-Swap)
- **Target File:** [`src/modules/bookings/services/bookings.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/bookings/services/bookings.service.ts)
- **Action:** Replace `findUnique` + `update` on lines 513–543 with atomic `updateMany`:
  ```typescript
  const updatedCount = await this.prisma.booking.updateMany({
    where: {
      id: bookingId,
      status: { in: ['REQUESTED', 'SEARCHING_DRIVER'] },
      driverId: null,
    },
    data: {
      status: 'DRIVER_ARRIVING',
      driverId: driver.id,
      vehicleId: driver.vehicle!.id,
      driverAssignedAt: new Date(),
    },
  });

  if (updatedCount.count === 0) {
    throw new AppException(
      'BOOKING_ALREADY_ACCEPTED',
      'This ride was already accepted by another driver',
      HttpStatus.CONFLICT,
    );
  }
  ```

---

### 1.6 Secure Start-Trip OTP Verification
- **Target File:** [`src/modules/bookings/services/bookings.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/bookings/services/bookings.service.ts)
- **Action:** Make `otp` mandatory, eliminate `'1234'` fallback, and remove `startOtp` from tracking endpoints:
  ```typescript
  if (!otp || typeof otp !== 'string') {
    throw new AppException('BAD_REQUEST', 'Start trip OTP is required', 400);
  }

  const cachedOtp = await this.redisService.client.get(`booking:${bookingId}:start_otp`);
  if (!cachedOtp || otp.trim() !== cachedOtp.trim()) {
    throw new AppException('BAD_REQUEST', 'Invalid start trip OTP. Please verify with customer.', 400);
  }
  await this.redisService.client.del(`booking:${bookingId}:start_otp`);
  ```

---

### 1.7 Prevent Wallet Double-Spend & Negative Balances
- **Target File:** [`src/modules/wallets/services/wallets.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/wallets/services/wallets.service.ts)
- **Action:** Enforce balance validation directly inside the atomic database update:
  ```typescript
  return this.prisma.$transaction(async (tx) => {
    const updated = await tx.driverWallet.updateMany({
      where: {
        id: wallet.id,
        balance: { gte: amount },
      },
      data: {
        balance: { decrement: amount },
        totalWithdrawn: { increment: amount },
      },
    });

    if (updated.count === 0) {
      throw new AppException('ERROR', 'Insufficient balance or concurrent transaction in progress', 400);
    }
    ...
  });
  ```

---

## 3. Phase 2: Core Engineering & Data Integrity (Week 1 – Week 2)
**Objective:** Restore architectural hygiene, bind dead middleware, enforce rate limits, and implement real dispatching.

### 2.1 Register Dead Cross-Cutting Architecture
1. **`GlobalExceptionFilter`:** Register in [`src/main.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/main.ts):
   ```typescript
   app.useGlobalFilters(new GlobalExceptionFilter());
   ```
2. **`ResponseInterceptor`:** Register in `main.ts`:
   ```typescript
   app.useGlobalInterceptors(new ResponseInterceptor());
   ```
3. **`RequestIdMiddleware`:** Implement in [`src/app.module.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/app.module.ts):
   ```typescript
   export class AppModule implements NestModule {
     configure(consumer: MiddlewareConsumer) {
       consumer.apply(RequestIdMiddleware).forRoutes('*');
     }
   }
   ```
4. **`ThrottlerGuard`:** Register in `app.module.ts` providers:
   ```typescript
   { provide: APP_GUARD, useClass: ThrottlerGuard },
   ```

---

### 2.2 Attach Clustered Redis IO Adapter
- **Target File:** `src/main.ts`
- **Implementation:**
  ```typescript
  import { IoAdapter } from '@nestjs/platform-socket.io';
  import { createAdapter } from '@socket.io/redis-adapter';
  import { createClient } from 'redis';

  export class RedisIoAdapter extends IoAdapter {
    private adapterConstructor: any;

    async connectToRedis(host: string, port: number): Promise<void> {
      const pubClient = createClient({ url: `redis://${host}:${port}` });
      const subClient = pubClient.duplicate();
      await Promise.all([pubClient.connect(), subClient.connect()]);
      this.adapterConstructor = createAdapter(pubClient, subClient);
    }

    createIOServer(port: number, options?: any) {
      const server = super.createIOServer(port, options);
      server.adapter(this.adapterConstructor);
      return server;
    }
  }

  // In bootstrap():
  const redisAdapter = new RedisIoAdapter(app);
  await redisAdapter.connectToRedis(redisHost, redisPort);
  app.useWebSocketAdapter(redisAdapter);
  ```

---

### 2.3 Migrate Financial Types from Float to Decimal
- **Target File:** [`prisma/schema.prisma`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/prisma/schema.prisma)
- **Action:** Convert `balance`, `totalEarned`, `totalWithdrawn`, `amount`, `balanceAfter`, `estimatedFare`, `finalFare` to `@db.Decimal(12, 2)`.
- **Database Migration:** Generate and execute Prisma migration:
  ```bash
  npx prisma migrate dev --name migrate_currencies_to_decimal
  ```

---

### 2.4 Implement Core Driver Matching Algorithm
- **Target File:** [`src/modules/bookings/services/driver-matching.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/bookings/services/driver-matching.service.ts)
- **Implementation:**
  1. Call `LocationsService.findNearbyDrivers(pickupLat, pickupLng, radiusKm = 5, max = 10)`.
  2. Filter drivers in PostgreSQL with `status: 'ONLINE'`, `isAvailable: true`, and matching `vehicleTypeId`.
  3. Fan-out real-time booking push offers (`booking:offer`) via Socket.IO directly to eligible driver sockets.
  4. Schedule a BullMQ timeout job (30s) to expand radius to 8 km if no driver accepts.

---

## 4. Phase 3: Infrastructure, Workers & I/O Optimization (Week 3 – Week 4)

### 3.1 Telemetry Decoupling & Redis Stream Buffering
- In `LocationGateway.handleLocationUpdate`:
  - Stop executing `saveBookingLocation` (synchronous PostgreSQL `INSERT`).
  - Append GPS coordinate pings to a Redis Stream:
    ```typescript
    await this.redisService.client.xadd(
      'stream:telemetry',
      '*',
      'bookingId', payload.bookingId,
      'driverId', driverId,
      'lat', lat.toString(),
      'lng', lng.toString(),
      'recordedAt', Date.now().toString(),
    );
    ```
- A background BullMQ consumer reads 500 coordinates per batch, downsamples to 1 point per 30 seconds per trip, and executes `prisma.bookingLocation.createMany()`.

---

### 3.2 Isolate BullMQ Workers from the HTTP API Process
- Remove `@Processor()` classes from `app.module.ts`.
- In [`src/jobs/worker.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/jobs/worker.ts), bootstrap a dedicated `JobsWorkerModule` containing only the processors.
- Update `docker-compose.yml` so that `api` runs only HTTP/WebSocket servers, and `worker` runs the background queues.

---

### 3.3 Container Hardening & Port Exposure Lockdown
- In [`Dockerfile`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/Dockerfile):
  - Add `tini` as entrypoint.
  - Execute `npm prune --production` before copying `node_modules` into the final stage.
  - Add `HEALTHCHECK --interval=30s --timeout=5s CMD wget -qO- http://localhost:3000/api/v1/health || exit 1`.
- In [`docker-compose.yml`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/docker-compose.yml):
  - Remove public `ports: ['5432:5432']` and `ports: ['6379:6379']`.
  - Add container memory limits (`mem_limit: 1024m`) and CPU quotas (`cpus: 1.5`).

---

## 5. Phase 4: Production Hardening, Compliance & Scale (Week 5 – Week 6)

### 5.1 UIDAI-Compliant Aadhaar Vault & Encryption
- In [`prisma/schema.prisma`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/prisma/schema.prisma):
  - Remove plaintext `aadhaarNumber String? @db.VarChar(20)`.
  - Store only `maskedAadhaar` (e.g. `XXXXXXXX1234`) and an encrypted reference ID (`aadhaarVaultToken`).
  - Store raw numbers in an AES-256-GCM encrypted external vault key or third-party verified reference ID (Zoop/Setu) in compliance with Section 29 of the Aadhaar Act.

---

### 5.2 Build Automated E2E Testing Suite
- Create `test/e2e/trip-lifecycle.e2e-spec.ts`.
- Implement automated verification of the 7-stage Porter trip lifecycle:
  ```typescript
  describe('Porter Trip Lifecycle E2E', () => {
    it('creates booking -> matches nearby driver -> accepts order -> verifies OTP -> completes trip -> settles wallet', async () => {
      // 1. POST /api/v1/bookings (Customer)
      // 2. Verify driver socket receives booking:offer
      // 3. POST /api/v1/bookings/:id/accept (Driver CAS test)
      // 4. POST /api/v1/bookings/:id/start-trip (Verify customer start_otp)
      // 5. POST /api/v1/bookings/:id/complete-trip
      // 6. Verify driver wallet balance incremented by fare - 15% commission
    });
  });
  ```

---

### 5.3 k6 Load Verification
- Execute 5,000 virtual user stress test against the staging cluster.
- Verify $p(95)$ latency $< 100\text{ms}$ on location pings and $< 200\text{ms}$ on booking endpoints.
- Confirm zero database connection pool timeouts and zero negative wallet balances under concurrent withdrawal attacks.
