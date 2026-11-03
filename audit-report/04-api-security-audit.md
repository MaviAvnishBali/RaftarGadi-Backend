# Raftar Gaddi – Backend Engineering Audit
# Document 04: API Security, Input Validation & Network Defense Audit

**Audit Date:** November 2026  
**Auditor:** Application Security Specialist & Network Architect  
**Component:** REST API Endpoints, Rate Limiting, Request Validation, CORS, Payload Limits, and Information Disclosure

---

## 1. Perimeter Defense Architecture Overview

The HTTP perimeter defense of Raftar Gaddi is orchestrated in [`src/main.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/main.ts):
- Security Headers via `helmet()`
- Payload Compression via `compression()`
- Global URI Prefix (`/api`) with URI Versioning (`/v1`)
- Global Validation Pipe with `whitelist: true`, `forbidNonWhitelisted: true`, and `transform: true`
- Swagger OpenAPI documentation mounted at `/api/docs`

---

## 2. Critical Security Findings

### 2.1 Complete Absence of HTTP Rate Limiting (`ThrottlerGuard` Defect)
In [`src/app.module.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/app.module.ts#L81-L86):
```typescript
// Rate Limiting Configuration
ThrottlerModule.forRoot([
  {
    ttl: parseInt(process.env.THROTTLE_TTL || '60000', 10),
    limit: parseInt(process.env.THROTTLE_LIMIT || '100', 10),
  },
]),
```
However, in [`src/app.module.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/app.module.ts#L125-L139), the `providers` array only registers:
```typescript
providers: [
  { provide: APP_GUARD, useClass: JwtAuthGuard },
  { provide: APP_GUARD, useClass: RolesGuard },
  { provide: APP_GUARD, useClass: PermissionsGuard },
  // ⚠️ CRITICAL OMISSION: ThrottlerGuard is NOT registered!
],
```

#### Vulnerability Assessment:
- **Severity: HIGH (CWE-770: Allocation of Resources Without Limits or Throttling)**
- **Impact:** NestJS requires `ThrottlerGuard` to be bound as an `APP_GUARD` to enforce rate limits globally. Without this binding, **the rate limiter is completely inactive**.
- **Consequences:**
  1. **SMS Gateway Depletion:** An attacker can script millions of requests to `POST /api/v1/auth/send-otp`, causing massive SMS billing costs or exhausting third-party SMS API limits.
  2. **Denial of Service (DoS):** Heavy endpoints like `GET /api/v1/reports/revenue` and `POST /api/v1/pricing/calculate` can be spammed to exhaust CPU and database connection pools.
  3. **Brute-Force Vulnerability:** No IP-based throttling exists to deter credential stuffing or coupon code guessing.

---

### 2.2 Broken Object Level Authorization (BOLA) & Driver Stalking
In [`src/modules/locations/controllers/locations.controller.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/locations/controllers/locations.controller.ts#L63-L77):

```typescript
// src/modules/locations/controllers/locations.controller.ts: Lines 63-77
@Get('booking/:bookingId')
@ApiOperation({ summary: 'Get live tracking data for a booking' })
async getBookingTracking(@Param('bookingId', ParseUUIDPipe) bookingId: string) {
  return this.locationsService.getBookingLiveTracking(bookingId);
}

@Get('driver/:driverId')
@ApiOperation({ summary: 'Get current coordinates for a driver' })
async getDriverLocation(@Param('driverId') driverId: string) {
  const location = await this.locationsService.getDriverLocation(driverId);
  if (!location) {
    throw new AppException('NOT_FOUND', 'Driver location not available', 404);
  }
  return location;
}
```

#### Vulnerability Assessment:
- **Severity: CRITICAL (OWASP API Security Top 10: API1:2023 Broken Object Level Authorization)**
- **Mechanics:**
  1. Neither endpoint has role restrictions (`@Roles()`), customer ownership validation, or driver assignment checks.
  2. Any user with a valid access token can enumerate `bookingId` UUIDs and obtain:
     - Customer full name, phone number, exact pickup address, and drop address.
     - Assigned driver full name, phone number, vehicle model, and registration plate.
     - Live latitude, longitude, and movement speed.
     - **The customer's secret `startOtp`!**
  3. `GET /locations/driver/:driverId` allows anyone to track any driver's live GPS coordinates continuously without an active booking, creating an immediate physical safety hazard.

---

### 2.3 Excessive HTTP Request Body Size (10MB JSON DoS)
In [`src/main.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/main.ts#L96):

```typescript
// src/main.ts: Line 96
// Request body size limit
app.use(require('express').json({ limit: '10mb' }));
```

#### Vulnerability Assessment:
- **Severity: MEDIUM (CWE-400: Uncontrolled Resource Consumption)**
- **Impact:** Logistics REST API payloads (creating a booking, updating location, submitting OTP) should rarely exceed 100 KB. Setting a global JSON parser body limit of **10 Megabytes** enables trivial event-loop denial of service:
  - An attacker sends large nested JSON payloads (e.g. 10MB arrays).
  - V8's synchronous `JSON.parse` blocks the single-threaded Node.js event loop for 100–300 milliseconds per request, freezing all concurrent WebSocket heartbeats and HTTP requests.
- **Remediation:** Reduce global Express JSON limit to `100kb`. Use streaming multipart handlers (`multer`) with strict file type and memory limits for document uploads.

---

### 2.4 Swagger OpenAPI Documentation Exposed in Production
In [`src/main.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/main.ts#L86-L93):

```typescript
// src/main.ts: Lines 86-93
const document = SwaggerModule.createDocument(app, swaggerConfig);
SwaggerModule.setup('api/docs', app, document, {
  swaggerOptions: {
    persistAuthorization: true,
    tagsSorter: 'alpha',
    operationsSorter: 'alpha',
  },
});
```

#### Vulnerability Assessment:
- **Severity: LOW / INFORMATION DISCLOSURE**
- **Impact:** The Swagger UI is unconditionally mounted at `/api/docs` without checking `configService.isProduction`.
- **Consequences:** Publicly exposes the full API schema, internal parameter names, admin endpoints, and security scheme specifications to external attackers, drastically lowering reconnaissance costs.
- **Remediation:** Wrap Swagger setup in an environment check:
  ```typescript
  if (!configService.isProduction) {
    SwaggerModule.setup('api/docs', app, document);
  }
  ```

---

### 2.5 Wildcard CORS in Real-Time WebSocket Gateway
In [`src/modules/locations/gateways/location.gateway.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/locations/gateways/location.gateway.ts#L18-L21):

```typescript
// src/modules/locations/gateways/location.gateway.ts: Lines 18-21
@WebSocketGateway({
  namespace: '/ws',
  cors: { origin: '*' },
})
```
While HTTP CORS in `main.ts` correctly restricts origins using `CORS_ORIGINS`, the WebSocket gateway explicitly permits **all origins (`*`)**.
- **Impact:** Malicious third-party websites can open WebSocket connections to the Raftar Gaddi backend from a victim's browser context (Cross-Site WebSocket Hijacking - CSWSH).
- **Remediation:** Bind WebSocket CORS to the validated whitelist from `AppConfigService`.

---

## 3. Summary of API Perimeter Security Controls

| Defense Layer | Implementation Status | Evaluation | Required Fix |
|---|---|---|---|
| **Helmet Security Headers** | Enabled (`app.use(helmet())`) | ✅ Good | Add explicit CSP directives for Swagger if enabled. |
| **HTTP Compression** | Enabled (`app.use(compression())`) | ✅ Good | Verify BREACH vulnerability mitigation for dynamic tokens. |
| **Global DTO Validation** | Enabled (`ValidationPipe`) | ✅ Good | Standardize `ParseUUIDPipe` across all ID route parameters. |
| **Rate Limiting** | Configured but **NOT Bound** | 🔴 Inactive | Register `ThrottlerGuard` in `AppModule` providers. |
| **BOLA / IDOR Protection** | Missing on tracking endpoints | 🔴 Broken | Enforce ownership check in `LocationsController`. |
| **JSON Payload Limits** | Overly Permissive (`10mb`) | ⚠️ Risky | Reduce to `100kb`; handle files via dedicated streaming multipart. |
| **Swagger Protection** | Publicly accessible in prod | ⚠️ Exposure | Restrict to non-production environments. |
| **WebSocket CORS** | Set to Wildcard `*` | ⚠️ Exposure | Bind to authorized origins. |
