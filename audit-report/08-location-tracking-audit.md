# Raftar Gaddi – Backend Engineering Audit
# Document 08: Location Tracking, Telemetry Ingestion & Geospatial I/O Audit

**Audit Date:** November 2026  
**Auditor:** Performance Engineer & Distributed Systems Architect  
**Component:** GPS Telemetry Ingestion, Redis GEO, PostgreSQL Write Throughput, and Tracking Scalability

---

## 1. Location Tracking Architecture Overview

The location pipeline ingest live GPS coordinates from drivers, indexes online drivers in Redis for geospatial proximity queries, and streams real-time breadcrumbs to customers tracking active deliveries:
- **Transport:** WebSocket event `location:update` on `/ws` namespace.
- **In-Memory Geo Index:** Redis Sorted Set `drivers:online` via `GEOADD`.
- **Driver State Cache:** Key-value string `driver:location:<driverId>` with a 24-hour TTL.
- **Persistent Breadcrumbs:** PostgreSQL table `booking_locations` via Prisma `saveBookingLocation()`.

---

## 2. Critical Scalability Bottlenecks & Architectural Flaws

### 2.1 The PostgreSQL Synchronous Write Collapse Anti-Pattern
In [`src/modules/locations/gateways/location.gateway.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/locations/gateways/location.gateway.ts#L145-L174):

```typescript
// src/modules/locations/gateways/location.gateway.ts: Lines 145-174
if (payload.bookingId) {
  const booking = await this.prisma.booking.findUnique({
    where: { id: payload.bookingId },
    select: { id: true, status: true, driverId: true },
  });
  ...
  // Persist location to PostgreSQL booking_locations
  await this.locationsService.saveBookingLocation(
    payload.bookingId,
    lat,
    lng,
    payload.heading,
    payload.speed,
  );
  ...
```

#### Mathematical Failure Analysis Under Scale:
- Real-time mobile driver applications emit GPS breadcrumbs every **3 to 5 seconds**.
- At **5,000 active concurrent trips**:
  - Pings per second: $5000 \div 3 = \mathbf{1,667\text{ pings/sec}}$.
  - Every single ping triggers:
    1. A synchronous `findUnique` query to PostgreSQL.
    2. A synchronous `INSERT INTO booking_locations` query to PostgreSQL.
  - Total synchronous database queries: **3,334 queries/second** directly hitting the relational database!
- **System Failure Progression:**
  1. Prisma's database connection pool (default 10–20 connections) is saturated in milliseconds.
  2. Node.js event loop blocks waiting for free database connections (`Timed out fetching a new connection from the connection pool`).
  3. Latency spikes from 20ms to > 10,000ms.
  4. HTTP endpoints (login, booking creation) time out and fail with 500 errors.
  5. The entire API server crashes due to connection starvation.

---

### 2.2 Redis GEO Zombie Member Accumulation
In [`src/modules/locations/services/locations.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/locations/services/locations.service.ts#L25-L39):

```typescript
// src/modules/locations/services/locations.service.ts: Lines 25-39
const client = this.redisService.client;
await client.geoadd('drivers:online', lng, lat, driverId);
await client.set(
  `driver:location:${driverId}`,
  JSON.stringify({ lat, lng, heading, speed, timestamp: Date.now() }),
  'EX',
  86400, // 24hr TTL
);
```

#### Root Cause:
1. Redis Geo Sets are implemented internally as **Sorted Sets (`ZSET`)**.
2. **Redis does NOT support per-member TTL in Sorted Sets.** While the string key `driver:location:${driverId}` expires in 24 hours, the member `driverId` inside `drivers:online` **never expires automatically**.
3. Drivers frequently disconnect uncleanly (phone battery dies, subway tunnels, mobile OS kills app in background). In these cases, `handleDisconnect` is never triggered.
4. Over weeks of operation, tens of thousands of offline/dead driver IDs remain permanently in `drivers:online`, bloating Redis memory and degrading `GEOSEARCH` query latency.

---

### 2.3 Sequential N+1 Network Round-Trips in `findNearbyDrivers`
In [`src/modules/locations/services/locations.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/locations/services/locations.service.ts#L131-L148):

```typescript
// src/modules/locations/services/locations.service.ts: Lines 131-148
for (const item of rawResults) {
  const driverId = Array.isArray(item) ? item[0] : item;
  ...
  // ⚠️ CRITICAL N+1 NETWORK BOTTLENECK!
  const locData = await client.get(`driver:location:${driverId}`);
  if (locData) {
    const parsed = JSON.parse(locData);
    if (parsed.timestamp && now - parsed.timestamp > staleThresholdMs) {
      continue;
    }
  }
  nearby.push({ driverId: String(driverId), distanceKm: dist });
}
```

#### Latency Analysis:
- When a customer checks for nearby drivers, `geosearch` returns up to `maxResults` drivers (e.g. 50 drivers).
- The service executes an `await client.get(...)` **sequentially inside a loop** for all 50 drivers!
- At an average network RTT of 1.5ms per Redis command:
  $$50 \times 1.5\text{ms} = \mathbf{75\text{ms to }150\text{ms of blocking I/O}}$$
- **Remediation:** Replace with a single pipelined or multi-key lookup:
  ```typescript
  const keys = rawResults.map((r) => `driver:location:${r.driverId}`);
  const locations = await client.mget(keys);
  ```

---

## 3. High-Throughput Telemetry Ingestion Architecture (Target Design)

```mermaid
flowchart LR
    subgraph MobileClients["Driver App"]
        GPS[GPS Ping 3s]
    end

    subgraph IngestionTier["Real-Time Ingestion (NestJS / WebSocket)"]
        WS[Socket.IO Gateway]
        R_GEO["Redis GEO (drivers:online)"]
        R_STREAM["Redis Stream (stream:locations)"]
    end

    subgraph BatchWorker["Batch Telemetry Consumer (BullMQ / Worker)"]
        BW[Downsampler & Buffer]
    end

    subgraph ColdStorage["Relational Cold Storage"]
        PG[("PostgreSQL 16 (TimescaleDB / Partitioned Table)")]
    end

    GPS -->|location:update| WS
    WS -->|O(1) Update| R_GEO
    WS -->|O(1) Append| R_STREAM
    WS -.->|NO SYNC DB WRITES| PG
    
    R_STREAM -->|Batch Read 500 records| BW
    BW -->|Downsampled 30s Batch INSERT| PG
```

### Key Recommendations:
1. **Eliminate Synchronous Database Writes on WebSocket Ingestion:**
   - Immediately decouple `saveBookingLocation` from the incoming WebSocket path.
   - Push location pings to a Redis Stream (`stream:locations`) or in-memory batch buffer.
2. **Batch Downsampling Consumer:**
   - A background worker reads 500 location records in a single batch from the Redis stream.
   - Downsamples breadcrumbs to 1 record per 15–30 seconds per trip.
   - Flushes batch inserts using `prisma.bookingLocation.createMany()` once every 5 seconds.
3. **Periodic Redis GEO Sweep Worker:**
   - Run a scheduled worker every 10 minutes to cross-check `drivers:online` against active connection states and remove stale members using `ZREM`.
4. **Use `MGET` for Multi-Driver State Fetching:**
   - Replace sequential `client.get()` in `findNearbyDrivers` with `client.mget()`.
