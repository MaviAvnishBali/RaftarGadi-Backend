# Raftar Gaddi – Backend Engineering Audit
# Document 09: Redis & Distributed Systems Architecture Audit

**Audit Date:** November 2026  
**Auditor:** Distributed Systems Architect & Senior DevOps Engineer  
**Component:** Redis In-Memory Store, Key Namespaces, Eviction Policies, Distributed Locking, and High Availability

---

## 1. Redis Infrastructure Topology

Redis 7 serves as the primary distributed state engine in Raftar Gaddi, managed by `RedisModule` ([`src/config/redis.module.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/config/redis.module.ts)) and `RedisService` ([`src/config/redis.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/config/redis.service.ts)) using the `ioredis` driver.

It powers five distinct workloads simultaneously:
1. **Authentication:** Temporary OTP storage (`otp:<phone>`) and attempt counters (`otp_attempts:<phone>`).
2. **Geospatial Tracking:** Driver geospatial indexing (`drivers:online`) and telemetry caching (`driver:location:<id>`).
3. **Trip Security:** Start-trip OTP cache (`booking:<id>:start_otp`).
4. **WebSocket Mapping:** Socket client session routing (`ws:client:<userId>`).
5. **Background Queues:** BullMQ job orchestration streams and hash keys (`bull:*`).

---

## 2. Key Distributed Systems Deficiencies

### 2.1 Single Point of Failure (SPOF) & High Availability Absence
In [`docker-compose.yml`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/docker-compose.yml#L62-L76) and [`src/config/redis.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/config/redis.service.ts#L17-L25):
- Redis is deployed as a single standalone node without replication, clustering, or automatic failover.
- **Critical Disaster Risk:**
  - If the single Redis instance experiences an out-of-memory crash, server restart, or network partition:
    1. All in-flight OTP verifications fail immediately.
    2. All BullMQ queue dispatching and background workers halt.
    3. All WebSocket connections reject client handshakes (`ws:client:*` writes fail).
    4. Real-time driver matching and live tracking collapse completely.
- **Production Requirement:** Deploy **Redis Sentinel** (1 primary, 2 replicas, 3 sentinels) or **AWS ElastiCache / Redis Cluster** with multi-AZ automatic failover.

---

### 2.2 Unbounded Memory Growth & Eviction Policy Risk
In [`docker-compose.yml`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/docker-compose.yml#L62-L76):
- Redis is launched without a custom `redis.conf`, without `maxmemory` constraints, and without an explicit `maxmemory-policy`.
- **Default Redis Behavior:**
  - The default memory eviction policy is **`noeviction`**.
  - When the host system's RAM is saturated (due to accumulated BullMQ job logs, zombie `drivers:online` entries, and stale keys), **Redis will reject all subsequent write commands with an error**:
    `OOM command not allowed when used memory > 'maxmemory'`
  - This immediately breaks authentication, job dispatch, and location tracking across the platform.
- **Remediation:** Configure `maxmemory` with a safety ceiling (e.g., 75% of container RAM) and set `maxmemory-policy volatile-lru` so Redis evicts expired or least-recently-used transient keys while preserving critical data.

---

### 2.3 Key Namespace Inconsistency & Collision Hazards
The codebase lacks a centralized key prefixing strategy. Keys are formatted inconsistently across different modules:

| Key Pattern | Module | TTL Set? | Collision Risk |
|---|---|---|---|
| `otp:<phone>` | `auth.service.ts` | Yes (300s) | Moderate (No app namespace) |
| `otp_attempts:<phone>` | `auth.service.ts` | Yes (300s) | Moderate |
| `booking:<id>:start_otp` | `bookings.service.ts` | No explicit TTL | High (Leaks memory) |
| `ws:client:<userId>` | `location.gateway.ts` | None | High (Relies on clean disconnect) |
| `drivers:online` | `locations.service.ts` | None (ZSET) | **Severe (Zombie drivers forever)** |
| `driver:location:<id>` | `locations.service.ts` | Yes (86400s) | Low |

- **Remediation:** Enforce a global namespace prefix (e.g. `rg:<env>:<domain>:<entity>:<id>`) via `ioredis` `keyPrefix` option.

---

### 2.4 Complete Absence of Distributed Locking (`Redlock`)
In a distributed backend with multiple API and worker containers, critical concurrent operations must be coordinated via distributed locks:
- **Missing Distributed Locks in Raftar Gaddi:**
  1. **Driver Booking Acceptance:** Two drivers accepting the same ride concurrently.
  2. **Wallet Withdrawals:** A driver requesting two concurrent withdrawals.
  3. **Coupon Redemptions:** A user redeeming a single-use coupon in parallel.
  4. **Stale Booking Sweeper:** Multiple API containers running cleanup jobs simultaneously.
- **Remediation:** Integrate `redlock` or `ioredis-lock` to guarantee mutual exclusion across distributed nodes:
  ```typescript
  const lock = await redlock.acquire([`locks:booking:${bookingId}`], 3000);
  try {
    // Execute critical section
  } finally {
    await lock.release();
  }
  ```

---

## 3. Summary of Distributed Systems Deficiencies

| Distributed Concern | Current Status | Risk | Target Architecture |
|---|---|---|---|
| **Topology** | Standalone Single Node | 🔴 SPOF | Redis Sentinel / AWS ElastiCache Multi-AZ |
| **Eviction Policy** | Default `noeviction` | 🔴 High | `volatile-lru` with defined `maxmemory` |
| **Distributed Locking** | None (Zero locks in code) | 🔴 High | Redlock distributed mutex for money & dispatch |
| **Connection Pooling** | Single ioredis instance | ⚠️ Medium | Connection pool with exponential backoff retry |
| **Adapter Synchronization** | Unattached Redis IO Adapter | 🔴 Broken | `@socket.io/redis-adapter` attached to NestJS |
