# Raftar Gaddi – Backend Engineering Audit
# Document 15: Testing Suite, Code Quality & Static Analysis Audit

**Audit Date:** November 2026  
**Auditor:** Senior Software Engineer in Test (SDET) & Code Quality Architect  
**Component:** Unit Tests, Integration Tests, E2E Tests, ESLint, TypeScript Strictness, and Prettier Formatting

---

## 1. Test Suite Execution & Health Summary

During this audit, automated test suites and linters were executed directly against the codebase. The empirical results demonstrate a **severely degraded test harness and total absence of end-to-end verification**:

```
─────────────────────────────────────────────────────────────
Test Suites Execution: 3 FAILED, 8 passed, 11 total
Tests:                 10 FAILED, 55 passed, 65 total
E2E Test Files:        0 files (0% E2E Coverage)
Integration Tests:     0 files (0% Integration Coverage)
ESLint Problems:       860 problems (164 errors, 696 warnings)
TypeScript Check:      Passed (Clean compilation with no syntax errors)
─────────────────────────────────────────────────────────────
```

---

## 2. Root Cause Analysis of Broken Test Suites

### 2.1 Suite Failure 1: `wallets.service.spec.ts`
```
FAIL src/modules/wallets/tests/wallets.service.spec.ts
● WalletsService › resolveDriverId › should resolve driver by id
  TypeError: Cannot read properties of undefined (reading 'findUnique')
    at WalletsService.resolveDriverId (src/modules/wallets/services/wallets.service.ts:21:40)
```
- **Root Cause:** In [`src/modules/wallets/services/wallets.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/wallets/services/wallets.service.ts#L20-L26), `resolveDriverId` directly queries `this.prisma.driver.findUnique`. However, the test module setup in `wallets.service.spec.ts` only mocked `WalletsRepository` and **failed to provide `PrismaService`** in the testing module.
- **Impact:** The entire wallet test suite is broken, leaving financial transactions completely unverified in CI/CD.

---

### 2.2 Suite Failure 2: `vehicles-available.spec.ts`
```
FAIL src/modules/vehicles/tests/vehicles-available.spec.ts
● VehiclesService › getAvailableVehicles › should filter by operational radius
  expect(received).toBe(expected) // Object.is equality
  Expected: 25
  Received: 50
    at Object.<anonymous> (src/modules/vehicles/tests/vehicles-available.spec.ts:64:32)
```
- **Root Cause:** A business logic change updated the maximum vehicle search radius in `VehiclesService` from 25 km to 50 km, but the developer failed to update the unit test expectations.
- **Impact:** Broken regression testing in CI/CD pipeline.

---

### 2.3 Suite Failure 3: `drivers-kyc.service.spec.ts`
```
FAIL src/modules/drivers/tests/drivers-kyc.service.spec.ts
● DriversService › KYC Submission
  Nest can't resolve dependencies of the DriversService (DriversRepository, KycVerificationService, ?).
  Please make sure that the argument at index [2] is available in the RootTestModule context.
    at Injector.lookupComponentInParent (node_modules/@nestjs/core/injector/injector.js:254:19)
```
- **Root Cause:** `DriversService` added a dependency on `RedisService` in its constructor, but the unit test module definition was never updated with a mock `RedisService`.
- **Impact:** The entire driver onboarding and KYC verification test suite crashes on initialization.

---

## 3. End-to-End (E2E) & Integration Testing Vacuum

Inspection of the test directory structure revealed:
- `test/jest-e2e.config.ts` exists.
- `test/jest-integration.config.ts` exists.
- **BUT ZERO (`0`) E2E test files (`*.e2e-spec.ts`) exist in the repository.**
- **ZERO (`0`) Integration test files exist.**

#### The Critical Risk of 0% E2E Testing:
The core business workflow of Raftar Gaddi involves complex distributed state synchronization between multiple actors:
1. Customer requests a ride via HTTP REST.
2. System geofences pickup and calculates fare.
3. System matches drivers in Redis GEO and broadcasts offers via Socket.IO.
4. Driver accepts order (atomic DB transaction).
5. Driver arrives and inputs Customer OTP.
6. Driver completes trip, finalizes fare, and triggers payment.
7. Payment gateway webhook confirms settlement and credits driver wallet.

**Not a single step of this core 7-stage workflow is covered by automated integration or E2E tests.** Every release relies entirely on manual testing with mobile devices, guaranteeing that regressions, race conditions, and financial bugs will slip into production.

---

## 4. Static Code Quality & Linting Analysis

Execution of `npm run lint` flagged **860 problems (164 errors, 696 warnings)**:

### 4.1 164 ESLint Errors
- **Prettier Mismatches:** 142 errors are trailing comma, line break, and indentation violations across test files and `vehicles.service.ts`.
- **Unused Variables:** 22 errors flag unused imports and dead variables (`no-unused-vars`).

### 4.2 696 ESLint Warnings
- **Pervasive `any` Types (`@typescript-eslint/no-explicit-any`):**
  - Over 420 instances of explicit `any` casting throughout critical business files.
  - Examples:
    - `location.gateway.ts` (Line 50): `let payload: any;`
    - `bookings.service.ts` (Line 581): `const booking = (await this.findById(bookingId)) as any;`
    - `bookings.service.ts` (Line 655): `const booking = (await this.findById(bookingId)) as any;`
  - Casting database models to `any` strips away TypeScript's compile-time property verification, allowing typos in column names to pass compilation cleanly and crash only in production runtime.
- **Missing Return Types (`@typescript-eslint/explicit-function-return-type`):**
  - Over 200 public controller and service methods omit explicit return types, violating NestJS best practices.

---

## 5. Testing & Code Quality Remediation Plan

1. **Repair Broken Unit Test Suites Immediately:**
   - Inject mock `PrismaService` into `wallets.service.spec.ts`.
   - Update radius expectation from 25 to 50 in `vehicles-available.spec.ts`.
   - Inject mock `RedisService` into `drivers-kyc.service.spec.ts`.
2. **Build Full Automated E2E Lifecycle Test:**
   - Create `test/e2e/booking-lifecycle.e2e-spec.ts` using Supertest + Socket.IO client.
   - Simulate complete Customer -> Driver -> Trip -> Payment lifecycle against an ephemeral PostgreSQL + Redis container.
3. **Resolve ESLint Errors & Enforce Prettier in Pre-Commit:**
   - Execute `npm run lint -- --fix` to resolve 164 formatting errors.
   - Install `husky` and `lint-staged` to enforce zero lint errors before git commits.
4. **Eliminate Pervasive `any` Types:**
   - Enforce Prisma-generated type models (`Booking & { customer: Customer; driver: Driver }`) instead of `any`.
