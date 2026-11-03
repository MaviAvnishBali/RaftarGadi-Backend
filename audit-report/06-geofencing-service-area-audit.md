# Raftar Gaddi – Backend Engineering Audit
# Document 06: Geofencing, Serviceable Areas & Spatial Boundary Audit

**Audit Date:** November 2026  
**Auditor:** Database Architect & Geospatial Systems Specialist  
**Component:** Geofencing Zones, Spatial Distance Formulas, Serviceability Validation, and PostGIS Readiness

---

## 1. Geofencing Architecture Overview

Geographical boundary validation in Raftar Gaddi is managed by the `ServiceableAreasModule` ([`src/modules/serviceable-areas/services/serviceable-areas.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/serviceable-areas/services/serviceable-areas.service.ts)).
Its primary responsibilities are:
1. Validating whether customer pickup coordinates fall within operational zones.
2. Managing operational cities (New Delhi, Noida, Gurugram, Mumbai, Bengaluru, etc.).
3. Preventing orders from outside active service territories.

---

## 2. Critical Geofencing & Spatial Deficiencies

### 2.1 The Circular Radius Fallacy in Logistics
In [`prisma/schema.prisma`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/prisma/schema.prisma#L664-L683) and [`serviceable-areas.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/serviceable-areas/services/serviceable-areas.service.ts#L62-L119):
```typescript
{
  name: 'New Delhi',
  state: 'Delhi NCR',
  centerLat: 28.6139,
  centerLng: 77.2090,
  radiusKm: 35.0,
  isActive: true,
}
```

#### Why Pure Radial Geofences Fail in Urban Logistics:
1. **Arbitrary Geometric Encroachment:** A 35 km circular radius centered at Connaught Place (28.6139, 77.2090) sweeps across parts of Noida (Uttar Pradesh), Gurugram (Haryana), Faridabad, and agricultural territories. Commercial goods vehicles in India face severe state permit barriers, border green taxes, and entry permits at state toll borders (MCD toll).
2. **Physical Barrier Inaccessibility:** Radial distance ignores rivers (Yamuna), railway tracks, and expressways with limited access points. Two points separated by 3 km Euclidean distance may require a 25 km detour due to river crossings.
3. **No GeoJSON Polygon Support:** Real on-demand logistics platforms (Porter, Uber Freight) utilize **MultiPolygon Geofences** conforming to municipal boundary lines, postal codes, and toll borders.

---

### 2.2 Un-Cached Database Round-Trips on Every Spatial Check
In [`src/modules/serviceable-areas/services/serviceable-areas.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/serviceable-areas/services/serviceable-areas.service.ts#L134-L141):

```typescript
// src/modules/serviceable-areas/services/serviceable-areas.service.ts: Lines 134-141
async findServingArea(lat: number, lng: number): Promise<ServingAreaMatch | null> {
  if (isNaN(lat) || isNaN(lng) || lat < -90 || lat > 90 || lng < -180 || lng > 180) {
    return null;
  }

  // ⚠️ CRITICAL I/O FLAW: Executes full DB query on every check!
  const activeAreas = await this.prisma.serviceableArea.findMany({
    where: { isActive: true },
  });
  ...
```

#### Performance & Scalability Impact:
- Whenever a customer opens the mobile app, moves their map pin, checks fare estimates, or requests a ride, `findServingArea` executes `SELECT * FROM serviceable_areas WHERE is_active = true` against PostgreSQL.
- Under 2,000 requests/second, this generates 2,000 unnecessary PostgreSQL queries every second for static reference data that changes at most once a month.
- **Remediation:** Cache active serviceable zones in Redis (`serviceable_areas:active`) or in application memory (LRU cache) with pub/sub invalidation when an admin modifies a zone.

---

### 2.3 Asymmetric Geofence Validation (Drop-Off Exclusion Vulnerability)
In [`src/modules/bookings/services/bookings.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/bookings/services/bookings.service.ts#L74-L81):

```typescript
// src/modules/bookings/services/bookings.service.ts: Lines 74-81
// Strictly validate that customer pickup point falls within an active operational area
if (this.serviceableAreasService && typeof dto.pickupLat === 'number' && typeof dto.pickupLng === 'number') {
  await this.serviceableAreasService.validateServiceability(
    dto.pickupLat,
    dto.pickupLng,
    dto.pickupAddress,
  );
}
```

#### Vulnerability & Business Impact:
- **Only the pickup coordinates (`pickupLat`, `pickupLng`) are validated!**
- The drop-off coordinates (`dropLat`, `dropLng`) are **never validated against serviceable zones**.
- A customer can place a 2-wheeler or mini-truck order with pickup in Connaught Place (New Delhi) and drop-off in **London, Dubai, or the Bay of Bengal**.
- The booking is accepted by the platform, charges a nonsensical estimated fare, and strands drivers.
- **Remediation:** Enforce dual geofence validation:
  ```typescript
  await Promise.all([
    this.serviceableAreasService.validateServiceability(dto.pickupLat, dto.pickupLng, dto.pickupAddress),
    this.serviceableAreasService.validateServiceability(dto.dropLat, dto.dropLng, dto.dropAddress),
  ]);
  ```

---

### 2.4 In-Memory O(N) Haversine Distance Bottleneck
In [`src/modules/serviceable-areas/services/serviceable-areas.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/serviceable-areas/services/serviceable-areas.service.ts#L35-L52, #L145-L160):
- For every incoming coordinate check, Node.js runs an in-memory loop evaluating the Haversine trigonometric formula across all zones:
  ```typescript
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + ...
  ```
- As Raftar Gaddi expands to 500+ micro-service zones across India, in-memory O(N) trigonometry loops consume excessive CPU cycles on the single-threaded Node.js event loop.

---

## 3. Spatial Upgrade Recommendations

```mermaid
flowchart TD
    subgraph CurrentImplementation["Current (In-Memory Flawed)"]
        A[Incoming Coordinate Lat/Lng] --> B[Prisma SELECT * FROM serviceable_areas]
        B --> C[O(N) In-Memory Haversine Loop]
        C --> D[Circular Radius Match]
    end

    subgraph ProposedEnterprise["Proposed (PostGIS + H3 Spatial)"]
        E[Incoming Coordinate Lat/Lng] --> F{In-Memory H3 Index?}
        F -->|Hit| G[Sub-Millisecond Zone ID Match]
        F -->|Miss| H[PostgreSQL PostGIS ST_Contains]
        H --> I[Spatial GIST Indexed Polygon Match]
    end
```

1. **Adopt PostGIS MultiPolygon Boundaries:**
   - Migrate `ServiceableArea` schema to store GeoJSON Polygons in PostgreSQL `geometry(Polygon, 4326)`.
   - Leverage `ST_Contains(boundary, ST_SetSRID(ST_Point(lng, lat), 4326))`.
2. **Implement Dual Geofence Checks:**
   - Both pickup and drop coordinates must be strictly checked before booking acceptance.
3. **Integrate Redis / H3 Hexagonal Grid Caching:**
   - Convert serviceable polygons into sets of Uber H3 Hexagonal indices (resolution 7 or 8) cached in Redis Sets.
   - Point-in-polygon checks become O(1) Redis `SISMEMBER` lookups taking < 1ms.
