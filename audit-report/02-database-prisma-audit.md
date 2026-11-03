# Raftar Gaddi – Backend Engineering Audit
# Document 02: Database & Prisma ORM Architecture Audit

**Audit Date:** November 2026  
**Auditor:** Database Architect & Senior Backend Engineer  
**Component:** PostgreSQL 16, Prisma Schema (`prisma/schema.prisma`), Indexes, Migrations, Data Integrity, and Geospatial Data

---

## 1. Database Schema Topology Overview

The persistence layer is managed by **PostgreSQL 16** via **Prisma ORM 5.22.0**. The schema defines 23 entity models and 12 enums across 684 lines in [`prisma/schema.prisma`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/prisma/schema.prisma).

```
Core Identity & Auth   : User, RefreshToken
Logistics Entities     : Customer, Driver, DriverDocument, VehicleType, Vehicle
Ride Lifecycle         : Booking, BookingStatusHistory, BookingLocation
Financial & Commerce   : PricingRule, Payment, DriverWallet, WalletTransaction, Coupon, CouponRedemption
Engagement & Ops       : Rating, Notification, SupportTicket, SupportMessage, AuditLog, IdempotencyKey, ServiceableArea
```

---

## 2. Critical Database Defects & Financial Risks

### 2.1 The Floating-Point Financial Anti-Pattern
In [`prisma/schema.prisma`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/prisma/schema.prisma), **all financial currency values are modeled using IEEE 754 double-precision floating-point numbers (`Float`)** instead of arbitrary-precision fixed-point numbers (`Decimal(12, 2)` or integer cents/paise).

#### Affected Fields in Schema:
```prisma
// DriverWallet (Lines 444-446)
model DriverWallet {
  balance        Float   @default(0.0)
  totalEarned    Float   @default(0.0) @map("total_earned")
  totalWithdrawn Float   @default(0.0) @map("total_withdrawn")
  ...
}

// WalletTransaction (Lines 468-469)
model WalletTransaction {
  amount       Float
  balanceAfter Float @map("balance_after")
  ...
}

// Booking (Lines 292, 295)
model Booking {
  estimatedFare Float? @map("estimated_fare")
  finalFare     Float? @map("final_fare")
  ...
}

// Payment (Line 390)
model Payment {
  amount Float
  ...
}

// PricingRule (Lines 342-350)
model PricingRule {
  baseFare           Float @map("base_fare")
  perKmCharge        Float @map("per_km_charge")
  perMinCharge       Float @map("per_min_charge")
  minimumFare        Float @map("minimum_fare")
  cancellationFee    Float @default(0.0) @map("cancellation_fee")
  platformFeePercent Float @default(0.0) @map("platform_fee_percent")
  taxPercent         Float @default(0.0) @map("tax_percent")
  surgeMultiplier    Float @default(1.0) @map("surge_multiplier")
  ...
}
```

#### Why This is Critical in Production:
Binary floating-point types (`DOUBLE PRECISION` / `Float`) cannot precisely represent decimal fractions such as `0.1` or `0.05`.
- Example: `0.1 + 0.2 = 0.30000000000000004`.
- Over hundreds of thousands of transactions, accumulated rounding drift will cause financial discrepancy between `DriverWallet.balance`, `WalletTransaction` history, and payment gateway settlement reports.
- Tax audits and banking reconciliation will fail.
- **Remediation:** Convert all currency amounts to `Decimal(12, 2)` (or `Decimal(14, 4)`) in Prisma:
  ```prisma
  balance Decimal @default(0.00) @db.Decimal(12, 2)
  ```

---

### 2.2 Complete Absence of Database CHECK Constraints
Prisma does not natively generate SQL `CHECK` constraints, requiring developers to write custom SQL migrations. Inspection of the database migrations revealed **zero SQL CHECK constraints** on the database tables.

#### Missing Critical Constraints:
1. **Wallet Solvency:** No `CHECK (balance >= 0)` on `driver_wallets`. A concurrency flaw or arithmetic glitch allows driver balances to plummet to `-₹15,000.00` without database rejection.
2. **Fare Non-Negativity:** No `CHECK (estimated_fare >= 0)` and `CHECK (final_fare >= 0)` on `bookings`.
3. **Geographic Coordinate Bounds:** No `CHECK (pickup_lat BETWEEN -90 AND 90 AND pickup_lng BETWEEN -180 AND 180)` on `bookings` and `serviceable_areas`.
4. **Distance and Weights:** No `CHECK (actual_distance_km >= 0)` or `CHECK (package_weight_kg > 0)`.

---

### 2.3 Destructive Cascade Deletion on Financial & Identity Records
In [`prisma/schema.prisma`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/prisma/schema.prisma):
```prisma
// Line 195: Customer to User
user User @relation(fields: [userId], references: [id], onDelete: Cascade)

// Line 233: Driver to User
user User @relation(fields: [userId], references: [id], onDelete: Cascade)

// Line 448: DriverWallet to Driver
driver Driver @relation(fields: [driverId], references: [id], onDelete: Cascade)

// Line 476: WalletTransaction to DriverWallet
wallet DriverWallet @relation(fields: [walletId], references: [id], onDelete: Cascade)
```

#### Catastrophic Data Loss Risk:
- If an admin or script deletes a `User` record, PostgreSQL cascades the deletion:
  `User` -> `Driver` -> `DriverWallet` -> **ALL `WalletTransaction` records**!
- All historical transaction logs, payouts, tax records, and earnings audits are instantly wiped from the database with zero recovery capability.
- **Remediation:** Remove `onDelete: Cascade` on all financial and operational relationships (`DriverWallet`, `WalletTransaction`, `Payment`, `Booking`). Enforce `onDelete: Restrict` and implement soft deletes (`deleted_at TIMESTAMP NULL`) with status `DEACTIVATED`.

---

## 3. High-Frequency Table Explosion: `BookingLocation`

In [`prisma/schema.prisma`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/prisma/schema.prisma#L324-L336):
```prisma
model BookingLocation {
  id         String   @id @default(uuid())
  bookingId  String   @map("booking_id")
  latitude   Float
  longitude  Float
  heading    Float?
  speed      Float?
  recordedAt DateTime @default(now()) @map("recorded_at")

  booking Booking @relation(fields: [bookingId], references: [id], onDelete: Cascade)

  @@index([bookingId])
  @@map("booking_locations")
}
```

#### Mathematical Scale Projection:
- 1 active driver emits GPS updates every 3 seconds = 20 pings per minute = 600 pings per 30-minute trip.
- At **5,000 concurrent active deliveries**:
  - Pings per second: **1,667 writes / sec** directly to `booking_locations`.
  - Pings per day (at 20,000 trips/day): **12,000,000 rows inserted daily**.
  - Pings per month: **360,000,000 rows**.
- **Current Architecture Consequences:**
  - Standard B-Tree index on `[bookingId]` will expand to hundreds of gigabytes in RAM, destroying cache efficiency.
  - Queries like `SELECT * FROM booking_locations WHERE booking_id = ... ORDER BY recorded_at DESC LIMIT 1` will suffer severe latency degradations.
- **Remediation:**
  1. Add compound index: `@@index([bookingId, recordedAt(sort: Desc)])`.
  2. Implement table partitioning by week/month (`PARTITION BY RANGE (recorded_at)`).
  3. Buffer high-frequency GPS pings in Redis Streams or memory, flushing downsampled GPS breadcrumbs (every 15–30 seconds) to Postgres, while keeping the latest coordinate in Redis GEO.

---

## 4. Database Indexing Analysis

| Table | Existing Indexes | Missing / Recommended Indexes | Reason & Query Impact |
|---|---|---|---|
| `bookings` | `[customerId, status]`, `[driverId, status]`, `[status]`, `[bookingNumber]` | `@@index([status, createdAt])` | Required for admin dashboard sorting & stale booking sweeps. |
| `booking_locations` | `[bookingId]` | `@@index([bookingId, recordedAt(sort: Desc)])` | Required for `getBookingLiveTracking` descending lookup. |
| `drivers` | `[userId]`, `[status]`, `[isAvailable]` | `@@index([status, isAvailable])` | Required for instant matching queries of online/available drivers. |
| `serviceable_areas` | None | `@@index([isActive])` | `findServingArea` queries `where: { isActive: true }` on every booking. |
| `driver_wallets` | `[driverId]` | Unique index is present. | Needs DB `CHECK (balance >= 0)`. |
| `audit_logs` | `[entityType, entityId]`, `[performedBy]`, `[action]` | `@@index([createdAt(sort: Desc)])` | Required for paginated admin audit log viewing. |

---

## 5. PostGIS & Geospatial Analysis

Currently, latitude and longitude coordinates are stored as disconnected scalar `Float` pairs (`pickupLat`, `pickupLng`, `centerLat`, `centerLng`).
- **Limitation:** PostgreSQL cannot perform hardware-accelerated spatial indexing (R-Tree / GIST).
- **In-Memory Bottleneck:** Every geofence check must fetch all rows from PostgreSQL and compute the Haversine trigonometric formula in Node.js CPU memory.
- **Remediation:**
  - Install PostGIS extension on PostgreSQL 16: `CREATE EXTENSION postgis;`.
  - Add native geometry columns:
    ```sql
    ALTER TABLE serviceable_areas ADD COLUMN boundary geometry(Polygon, 4326);
    CREATE INDEX idx_serviceable_areas_geom ON serviceable_areas USING GIST (boundary);
    ```
  - Leverage native spatial operators: `ST_Contains(boundary, ST_SetSRID(ST_Point(lng, lat), 4326))`.

---

## 6. Database Connection Pooling & PgBouncer

In `Dockerfile` and `docker-compose.yml`:
- The API container connects directly to PostgreSQL port 5432 using Prisma.
- Prisma uses an internal connection pool default of `num_physical_cpus * 2 + 1` (typically 5 to 10 connections per container).
- When scaling horizontally to 10 API replicas + 4 worker replicas, the total connection count easily exceeds Postgres's default `max_connections = 100`, resulting in immediate `FATAL: remaining connection slots are reserved for non-replication superuser connections`.
- **Recommendation:** Deploy **PgBouncer** in transaction pooling mode between NestJS and PostgreSQL to support thousands of client connections with minimal PostgreSQL backend overhead.
