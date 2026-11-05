# Raftar Gaddi – Backend API Reference Documentation

> **Auto-Generated & Verified**: 2026-11-05  
> **API Version**: `v1`  
> **Total REST Endpoints**: **103**  
> **Total WebSocket Handlers**: **6 Events**  
> **Interactive Swagger UI**: [`http://localhost:3000/api/docs`](http://localhost:3000/api/docs) or [`https://l7q2wkvw-3000.inc1.devtunnels.ms/api/docs`](https://l7q2wkvw-3000.inc1.devtunnels.ms/api/docs)  
> **Raw OpenAPI JSON**: [`/api/docs-json`](http://localhost:3000/api/docs-json)

---

## Table of Contents

- [1. Authentication & Identity (6 Endpoints)](#1-authentication-identity)
- [2. Customers (4 Endpoints)](#2-customers)
- [3. Drivers & KYC (13 Endpoints)](#3-drivers-kyc)
- [4. Vehicles & Fleet (7 Endpoints)](#4-vehicles-fleet)
- [5. Bookings & Trip Lifecycle (12 Endpoints)](#5-bookings-trip-lifecycle)
- [6. Pricing, Fares & Surge (5 Endpoints)](#6-pricing,-fares-surge)
- [7. Payments & Webhooks (5 Endpoints)](#7-payments-webhooks)
- [8. Wallets & Driver Payouts (5 Endpoints)](#8-wallets-driver-payouts)
- [9. Locations & GPS Tracking (3 Endpoints)](#9-locations-gps-tracking)
- [10. Ratings & Feedback (3 Endpoints)](#10-ratings-feedback)
- [11. Coupons & Promotions (6 Endpoints)](#11-coupons-promotions)
- [12. Notifications (5 Endpoints)](#12-notifications)
- [13. Support & Live Chat (10 Endpoints)](#13-support-live-chat)
- [14. Admin Management & Analytics (9 Endpoints)](#14-admin-management-analytics)
- [15. Serviceable Operational Areas (7 Endpoints)](#15-serviceable-operational-areas)
- [16. System Health & Probes (3 Endpoints)](#16-system-health-probes)
- [17. Real-Time WebSocket Gateway (`/ws`)](#17-real-time-websocket-gateway-ws)
- [18. Future API Development & Auto-Sync Protocol](#18-future-api-development--auto-sync-protocol)

---

## Global API Conventions

### Base URLs
- **Local Development**: `http://localhost:3000/api/v1`
- **Staging / Public Tunnel**: `https://l7q2wkvw-3000.inc1.devtunnels.ms/api/v1`
- **WebSocket Gateway**: `wss://l7q2wkvw-3000.inc1.devtunnels.ms/ws` (or `ws://localhost:3000/ws`)

### Authentication & Authorization
All authenticated endpoints require an HTTP header:
```http
Authorization: Bearer <jwt_access_token>
```
- **Roles**: `CUSTOMER`, `DRIVER`, `ADMIN`, `SUPER_ADMIN`.
- Tokens are issued via `POST /api/v1/auth/verify-otp` with a 15-minute access token TTL and a 7-day refresh token TTL.

### Standard Response Envelope
```json
{
  "statusCode": 200,
  "data": { ... },
  "message": "Success"
}
```

### Standard Error Envelope
```json
{
  "statusCode": 400,
  "message": "Validation failed: phone must be a valid phone number",
  "error": "Bad Request",
  "timestamp": "2026-11-05T12:00:00.000Z",
  "path": "/api/v1/auth/send-otp"
}
```

---

## 1. Authentication & Identity

*User login via Phone OTP, JWT generation, token refresh, and multi-device revocation.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **POST** | `/api/v1/auth/logout` | Logout user from current device | 🌐 Public | `RefreshTokenDto` |
| **POST** | `/api/v1/auth/logout-all` | Logout user from all devices | 🌐 Public | - |
| **GET** | `/api/v1/auth/me` | Get current user profile | 🌐 Public | - |
| **POST** | `/api/v1/auth/refresh` | Refresh access token | 🌐 Public | `RefreshTokenDto` |
| **POST** | `/api/v1/auth/send-otp` | Send OTP to phone | 🌐 Public | `SendOtpDto` |
| **POST** | `/api/v1/auth/verify-otp` | Verify OTP and login | 🌐 Public | `VerifyOtpDto` |


### POST `/api/v1/auth/logout`

**Description**: Logout user from current device

**Access**: 🌐 Public Endpoint

**Request Body** (`RefreshTokenDto`):

- `refreshToken` (`string`, **required**) — The refresh token

**Responses**:

- **`200`**: Logged out successfully
- **`201`**: Response payload

---

### POST `/api/v1/auth/logout-all`

**Description**: Logout user from all devices

**Access**: 🌐 Public Endpoint

**Responses**:

- **`200`**: Logged out from all devices successfully
- **`201`**: Response payload

---

### GET `/api/v1/auth/me`

**Description**: Get current user profile

**Access**: 🌐 Public Endpoint

**Responses**:

- **`200`**: Returns current user profile

---

### POST `/api/v1/auth/refresh`

**Description**: Refresh access token

**Access**: 🌐 Public Endpoint

**Request Body** (`RefreshTokenDto`):

- `refreshToken` (`string`, **required**) — The refresh token

**Responses**:

- **`200`**: Tokens refreshed
- **`201`**: Response payload

---

### POST `/api/v1/auth/send-otp`

**Description**: Send OTP to phone

**Access**: 🌐 Public Endpoint

**Request Body** (`SendOtpDto`):

- `phone` (`string`, **required**) — The phone number to send OTP to

**Responses**:

- **`200`**: OTP sent successfully
- **`201`**: Response payload

---

### POST `/api/v1/auth/verify-otp`

**Description**: Verify OTP and login

**Access**: 🌐 Public Endpoint

**Request Body** (`VerifyOtpDto`):

- `phone` (`string`, **required**) — The phone number the OTP was sent to
- `otp` (`string`, **required**) — The 6-digit OTP
- `role` (`string`, optional) [Allowed: `CUSTOMER, DRIVER, ADMIN, SUPER_ADMIN`] *(default: `CUSTOMER`)*
- `deviceInfo` (`string`, optional) — Device information

**Responses**:

- **`200`**: User authenticated successfully
- **`201`**: Response payload

---

## 2. Customers

*Customer profile management and administrative customer directory.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **GET** | `/api/v1/customers` | List all customers (Admin) | 🔒 JWT | - |
| **GET** | `/api/v1/customers/profile` | Get customer profile | 🔒 JWT | - |
| **PATCH** | `/api/v1/customers/profile` | Update customer profile | 🔒 JWT | `UpdateCustomerDto` |
| **GET** | `/api/v1/customers/{id}` | Get customer by id (Admin) | 🔒 JWT | - |


### GET `/api/v1/customers`

**Description**: List all customers (Admin)

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |
| `search` | `query` | `string` | No | Search customer name or phone |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/customers/profile`

**Description**: Get customer profile

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

### PATCH `/api/v1/customers/profile`

**Description**: Update customer profile

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`UpdateCustomerDto`):

- `name` (`string`, optional) — Full name of the customer
- `email` (`string`, optional) — Email address of the customer
- `address` (`string`, optional)
- `savedLat` (`number`, optional)
- `savedLng` (`number`, optional)

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/customers/{id}`

**Description**: Get customer by id (Admin)

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

## 3. Drivers & KYC

*Driver onboarding, real-time availability toggle, license/Aadhaar KYC submission, and verification.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **GET** | `/api/v1/drivers` | List all drivers | 🔒 JWT | - |
| **GET** | `/api/v1/drivers/dashboard` | Get driver home dashboard data | 🔒 JWT | - |
| **POST** | `/api/v1/drivers/documents` | Upload document | 🔒 JWT | `UploadDocumentDto` |
| **POST** | `/api/v1/drivers/go-offline` | Go offline | 🔒 JWT | - |
| **POST** | `/api/v1/drivers/go-online` | Go online | 🔒 JWT | - |
| **POST** | `/api/v1/drivers/kyc-details` | Submit driving license and Aadhaar details for KYC | 🔒 JWT | `SubmitKycDto` |
| **GET** | `/api/v1/drivers/profile` | Get own driver profile | 🔒 JWT | - |
| **PATCH** | `/api/v1/drivers/profile` | Update driver profile | 🔒 JWT | `UpdateDriverDto` |
| **POST** | `/api/v1/drivers/register` | Register as driver | 🔒 JWT | `RegisterDriverDto` |
| **POST** | `/api/v1/drivers/verify-license` | Verify and save driving license | 🔒 JWT | `VerifyLicenseDto` |
| **GET** | `/api/v1/drivers/{id}` | Get driver by id | 🔒 JWT | - |
| **POST** | `/api/v1/drivers/{id}/approve` | Approve driver KYC | 🔒 JWT | - |
| **POST** | `/api/v1/drivers/{id}/suspend` | Suspend driver | 🔒 JWT | - |


### GET `/api/v1/drivers`

**Description**: List all drivers

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |
| `status` | `query` | `string` | No | Driver status (OFFLINE, ONLINE, BUSY, SUSPENDED, ACTIVE, PENDING_KYC, ALL) |
| `kycStatus` | `query` | `string` | No | - |
| `search` | `query` | `string` | No | - |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/drivers/dashboard`

**Description**: Get driver home dashboard data

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/drivers/documents`

**Description**: Upload document

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`UploadDocumentDto`):

- `documentType` (`string`, **required**) [Allowed: `LICENSE, AADHAAR, PAN, RC, INSURANCE, PHOTO`]
- `documentUrl` (`string`, **required**)

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/drivers/go-offline`

**Description**: Go offline

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/drivers/go-online`

**Description**: Go online

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/drivers/kyc-details`

**Description**: Submit driving license and Aadhaar details for KYC

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`SubmitKycDto`):

- `licenseNumber` (`string`, **required**) — Standard Indian Driving License Number (without spaces or dashes)
- `dob` (`string`, **required**) — Driver Date of Birth (YYYY-MM-DD)
- `aadhaarNumber` (`string`, **required**) — 12-digit Aadhaar Number
- `aadhaarName` (`string`, **required**) — Full Name as printed on Aadhaar Card
- `licenseExpiry` (`string`, optional) — Optional Driving License Expiry Date (YYYY-MM-DD)

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/drivers/profile`

**Description**: Get own driver profile

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

### PATCH `/api/v1/drivers/profile`

**Description**: Update driver profile

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`UpdateDriverDto`):

- `licenseNumber` (`string`, optional)

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/drivers/register`

**Description**: Register as driver

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`RegisterDriverDto`):

- `licenseNumber` (`string`, **required**)

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/drivers/verify-license`

**Description**: Verify and save driving license

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`VerifyLicenseDto`):

- `licenseNumber` (`string`, **required**) — The Driving License Number to verify

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/drivers/{id}`

**Description**: Get driver by id

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/drivers/{id}/approve`

**Description**: Approve driver KYC

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/drivers/{id}/suspend`

**Description**: Suspend driver

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`201`**: Response payload

---

## 4. Vehicles & Fleet

*Fleet vehicle registration, specifications, dimension tiers, and geofenced vehicle discovery.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **GET** | `/api/v1/vehicles/available-nearby` | Get available vehicles nearby within progressive 10km -> 15km -> 25km geofence | 🔒 JWT | - |
| **GET** | `/api/v1/vehicles/my-vehicle` | Get own vehicle | 🔒 JWT | - |
| **POST** | `/api/v1/vehicles/register` | Register vehicle | 🔒 JWT | `RegisterVehicleDto` |
| **GET** | `/api/v1/vehicles/types` | List vehicle types | 🔒 JWT | - |
| **POST** | `/api/v1/vehicles/types` | Create vehicle type | 🔒 JWT | `CreateVehicleTypeDto` |
| **PATCH** | `/api/v1/vehicles/types/{id}` | Update vehicle type dimensions and specs | 🔒 JWT | - |
| **PATCH** | `/api/v1/vehicles/{id}` | Update vehicle | 🔒 JWT | `UpdateVehicleDto` |


### GET `/api/v1/vehicles/available-nearby`

**Description**: Get available vehicles nearby within progressive 10km -> 15km -> 25km geofence

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `lat` | `query` | `number` | **Yes** | Customer current or pickup latitude |
| `lng` | `query` | `number` | **Yes** | Customer current or pickup longitude |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/vehicles/my-vehicle`

**Description**: Get own vehicle

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/vehicles/register`

**Description**: Register vehicle

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`RegisterVehicleDto`):

- `vehicleTypeId` (`string`, **required**)
- `registrationNumber` (`string`, **required**)
- `model` (`string`, optional)
- `bodyType` (`string`, optional) [Allowed: `OPEN, CLOSED_CONTAINER, TARPAULIN`]
- `color` (`string`, optional)
- `manufactureYear` (`number`, optional)

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/vehicles/types`

**Description**: List vehicle types

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/vehicles/types`

**Description**: Create vehicle type

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`CreateVehicleTypeDto`):

- `name` (`string`, **required**)
- `description` (`string`, optional)
- `maxWeightKg` (`number`, optional)
- `dimensions` (`string`, optional)
- `iconUrl` (`string`, optional)
- `sortOrder` (`number`, optional)
- `baseFare` (`number`, optional) — Initial base fare in INR
- `perKmCharge` (`number`, optional) — Initial per km rate in INR
- `perMinCharge` (`number`, optional) — Initial per minute rate in INR
- `minimumFare` (`number`, optional) — Initial minimum fare in INR

**Responses**:

- **`201`**: Response payload

---

### PATCH `/api/v1/vehicles/types/{id}`

**Description**: Update vehicle type dimensions and specs

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

### PATCH `/api/v1/vehicles/{id}`

**Description**: Update vehicle

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Request Body** (`UpdateVehicleDto`):

- `vehicleTypeId` (`string`, optional)
- `registrationNumber` (`string`, optional)
- `model` (`string`, optional)
- `bodyType` (`string`, optional) [Allowed: `OPEN, CLOSED_CONTAINER, TARPAULIN`]
- `color` (`string`, optional)
- `manufactureYear` (`number`, optional)

**Responses**:

- **`200`**: Response payload

---

## 5. Bookings & Trip Lifecycle

*Full booking state machine: creation, geofenced dispatch, driver acceptance, arrival, OTP verification, and completion.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **POST** | `/api/v1/bookings` | BookingsController_createBooking | 🔒 JWT | `CreateBookingDto` |
| **GET** | `/api/v1/bookings` | BookingsController_getCustomerBookings | 🔒 JWT | - |
| **GET** | `/api/v1/bookings/all` | BookingsController_getAllBookings | 🔒 JWT | - |
| **GET** | `/api/v1/bookings/driver` | BookingsController_getDriverBookings | 🔒 JWT | - |
| **POST** | `/api/v1/bookings/simulate-order` | Simulate an incoming order for online driver | 🔒 JWT | - |
| **GET** | `/api/v1/bookings/stats` | BookingsController_getBookingStats | 🔒 JWT | - |
| **GET** | `/api/v1/bookings/{id}` | BookingsController_getBookingById | 🔒 JWT | - |
| **POST** | `/api/v1/bookings/{id}/accept` | Accept incoming order | 🔒 JWT | - |
| **POST** | `/api/v1/bookings/{id}/arrived` | Driver arrived at pickup | 🔒 JWT | - |
| **POST** | `/api/v1/bookings/{id}/cancel` | BookingsController_cancelBooking | 🔒 JWT | `CancelBookingDto` |
| **POST** | `/api/v1/bookings/{id}/complete` | Complete delivery trip | 🔒 JWT | `CompleteTripDto` |
| **POST** | `/api/v1/bookings/{id}/start` | Start delivery trip | 🔒 JWT | `StartTripDto` |


### POST `/api/v1/bookings`

**Description**: BookingsController_createBooking

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `idempotency-key` | `header` | `string` | **Yes** | - |

**Request Body** (`CreateBookingDto`):

- `pickupLat` (`number`, **required**) — Pickup latitude
- `pickupLng` (`number`, **required**) — Pickup longitude
- `pickupAddress` (`string`, **required**) — Pickup address string
- `dropLat` (`number`, **required**) — Drop latitude
- `dropLng` (`number`, **required**) — Drop longitude
- `dropAddress` (`string`, **required**) — Drop address string
- `vehicleTypeId` (`string`, optional) — Vehicle type ID
- `vehicleType` (`string`, optional) — Vehicle type name (e.g. bike, auto, miniTruck)
- `customerId` (`string`, optional) — Customer ID override
- `estimatedFare` (`number`, optional) — Estimated fare
- `estimatedDistanceKm` (`number`, optional) — Estimated distance in km
- `estimatedDurationMin` (`number`, optional) — Estimated duration in minutes
- `note` (`string`, optional) — Delivery note
- `packageType` (`string`, optional) — Package type
- `packageDescription` (`string`, optional) — Package description
- `packageWeightKg` (`number`, optional) — Package weight in kg
- `paymentMethod` (`string`, optional) [Allowed: `CASH, UPI, CARD, WALLET`] — Payment method
- `couponCode` (`string`, optional) — Coupon code
- `scheduledAt` (`string`, optional) — Scheduled date and time
- `pickup` (`object`, optional) — Pickup object metadata
- `drop` (`object`, optional) — Drop object metadata
- `fare` (`object`, optional) — Fare object metadata

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/bookings`

**Description**: BookingsController_getCustomerBookings

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |
| `status` | `query` | `string` | No | Booking status or group (IN_TRANSIT, PENDING, COMPLETED, CANCELLED, etc.) |
| `from` | `query` | `string` | No | From date (ISO string) |
| `customerId` | `query` | `string` | No | Customer ID |
| `to` | `query` | `string` | No | To date (ISO string) |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/bookings/all`

**Description**: BookingsController_getAllBookings

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |
| `status` | `query` | `string` | No | Booking status or group (IN_TRANSIT, PENDING, COMPLETED, CANCELLED, etc.) |
| `from` | `query` | `string` | No | From date (ISO string) |
| `customerId` | `query` | `string` | No | Customer ID |
| `to` | `query` | `string` | No | To date (ISO string) |
| `driverId` | `query` | `string` | No | Driver ID |
| `paymentStatus` | `query` | `string` | No | - |
| `search` | `query` | `string` | No | Search term (booking number, etc.) |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/bookings/driver`

**Description**: BookingsController_getDriverBookings

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |
| `status` | `query` | `string` | No | Booking status or group (IN_TRANSIT, PENDING, COMPLETED, CANCELLED, etc.) |
| `from` | `query` | `string` | No | From date (ISO string) |
| `customerId` | `query` | `string` | No | Customer ID |
| `to` | `query` | `string` | No | To date (ISO string) |

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/bookings/simulate-order`

**Description**: Simulate an incoming order for online driver

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/bookings/stats`

**Description**: BookingsController_getBookingStats

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/bookings/{id}`

**Description**: BookingsController_getBookingById

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/bookings/{id}/accept`

**Description**: Accept incoming order

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/bookings/{id}/arrived`

**Description**: Driver arrived at pickup

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/bookings/{id}/cancel`

**Description**: BookingsController_cancelBooking

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Request Body** (`CancelBookingDto`):

- `reason` (`string`, optional) — Reason for cancellation

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/bookings/{id}/complete`

**Description**: Complete delivery trip

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Request Body** (`CompleteTripDto`):

- `actualDistanceKm` (`number`, **required**) — Actual distance covered in km
- `actualDurationMin` (`number`, **required**) — Actual duration taken in minutes

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/bookings/{id}/start`

**Description**: Start delivery trip

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Request Body** (`StartTripDto`):

- `otp` (`string`, optional) — Customer pickup verification OTP

**Responses**:

- **`201`**: Response payload

---

## 6. Pricing, Fares & Surge

*Distance/weight fare calculation, customizable pricing rules, and dynamic surge multipliers.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **POST** | `/api/v1/pricing/estimate` | Calculate fare estimate | 🔒 JWT | `CalculateFareDto` |
| **GET** | `/api/v1/pricing/rules` | List pricing rules | 🔒 JWT | - |
| **POST** | `/api/v1/pricing/rules` | Create pricing rule | 🔒 JWT | `CreatePricingRuleDto` |
| **PATCH** | `/api/v1/pricing/rules/{id}` | Update pricing rule | 🔒 JWT | `UpdatePricingRuleDto` |
| **POST** | `/api/v1/pricing/surge` | Set surge multiplier | 🔒 JWT | - |


### POST `/api/v1/pricing/estimate`

**Description**: Calculate fare estimate

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`CalculateFareDto`):

- `vehicleTypeId` (`string`, optional) — Vehicle Type ID (UUID)
- `vehicleType` (`string`, optional) — Vehicle Type name (e.g. bike, auto, miniTruck)
- `distanceKm` (`number`, **required**) — Distance in kilometers
- `durationMin` (`number`, optional) — Duration in minutes
- `durationMinutes` (`number`, optional) — Duration in minutes (alias)
- `city` (`string`, optional) *(default: `default`)* — City name
- `couponCode` (`string`, optional) — Optional coupon code

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/pricing/rules`

**Description**: List pricing rules

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/pricing/rules`

**Description**: Create pricing rule

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`CreatePricingRuleDto`):

- `vehicleTypeId` (`string`, **required**)
- `city` (`string`, optional)
- `baseFare` (`number`, **required**)
- `perKmCharge` (`number`, **required**)
- `perMinCharge` (`number`, **required**)
- `minimumFare` (`number`, **required**)
- `platformFeePercent` (`number`, **required**)
- `taxPercent` (`number`, **required**)
- `surgeMultiplier` (`number`, optional)
- `effectiveFrom` (`string`, **required**)
- `effectiveTo` (`string`, optional)

**Responses**:

- **`201`**: Response payload

---

### PATCH `/api/v1/pricing/rules/{id}`

**Description**: Update pricing rule

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Request Body** (`UpdatePricingRuleDto`):

- `vehicleTypeId` (`string`, optional)
- `city` (`string`, optional)
- `baseFare` (`number`, optional)
- `perKmCharge` (`number`, optional)
- `perMinCharge` (`number`, optional)
- `minimumFare` (`number`, optional)
- `platformFeePercent` (`number`, optional)
- `taxPercent` (`number`, optional)
- `surgeMultiplier` (`number`, optional)
- `effectiveFrom` (`string`, optional)
- `effectiveTo` (`string`, optional)
- `dimensions` (`string`, optional) — Vehicle cargo bed dimensions (e.g. 7ft x 4.8ft x 4.8ft)
- `maxWeightKg` (`number`, optional) — Max vehicle payload capacity in kg

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/pricing/surge`

**Description**: Set surge multiplier

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

## 7. Payments & Webhooks

*Payment initiation, payment gateway webhooks, transaction history, and refunds.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **GET** | `/api/v1/payments` | List all payments | 🔒 JWT | - |
| **GET** | `/api/v1/payments/booking/{bookingId}` | Get payments for a booking | 🔒 JWT | - |
| **POST** | `/api/v1/payments/initiate` | Initiate payment | 🔒 JWT | `InitiatePaymentDto` |
| **POST** | `/api/v1/payments/webhook` | Process payment webhook | 🔒 JWT | `WebhookPayloadDto` |
| **POST** | `/api/v1/payments/{id}/refund` | Refund a payment | 🔒 JWT | - |


### GET `/api/v1/payments`

**Description**: List all payments

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |
| `status` | `query` | `string` | No | - |
| `method` | `query` | `string` | No | - |
| `from` | `query` | `string` | No | - |
| `to` | `query` | `string` | No | - |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/payments/booking/{bookingId}`

**Description**: Get payments for a booking

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `bookingId` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/payments/initiate`

**Description**: Initiate payment

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `idempotency-key` | `header` | `string` | No | - |

**Request Body** (`InitiatePaymentDto`):

- `bookingId` (`string`, **required**)
- `method` (`string`, **required**) [Allowed: `CASH, UPI, CARD, WALLET`]

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/payments/webhook`

**Description**: Process payment webhook

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`WebhookPayloadDto`):

- `orderId` (`string`, **required**)
- `status` (`string`, **required**)
- `transactionId` (`string`, **required**)
- `signature` (`string`, **required**)

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/payments/{id}/refund`

**Description**: Refund a payment

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

## 8. Wallets & Driver Payouts

*Driver wallet balances, earnings transactions, settlement ledger, and withdrawal requests.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **GET** | `/api/v1/wallets/driver/{driverId}` | Admin view driver wallet | 🔒 JWT | - |
| **GET** | `/api/v1/wallets/driver/{driverId}/transactions` | Admin view driver wallet transactions | 🔒 JWT | - |
| **GET** | `/api/v1/wallets/my-wallet` | Get current driver wallet | 🔒 JWT | - |
| **GET** | `/api/v1/wallets/my-wallet/transactions` | Get current driver wallet transactions | 🔒 JWT | - |
| **POST** | `/api/v1/wallets/withdraw` | Request withdrawal | 🔒 JWT | `WalletOperationDto` |


### GET `/api/v1/wallets/driver/{driverId}`

**Description**: Admin view driver wallet

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `driverId` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/wallets/driver/{driverId}/transactions`

**Description**: Admin view driver wallet transactions

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `driverId` | `path` | `string` | **Yes** | - |
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |
| `type` | `query` | `string` | No | - |
| `from` | `query` | `string` | No | - |
| `to` | `query` | `string` | No | - |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/wallets/my-wallet`

**Description**: Get current driver wallet

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/wallets/my-wallet/transactions`

**Description**: Get current driver wallet transactions

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |
| `type` | `query` | `string` | No | - |
| `from` | `query` | `string` | No | - |
| `to` | `query` | `string` | No | - |

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/wallets/withdraw`

**Description**: Request withdrawal

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`WalletOperationDto`):

- `amount` (`number`, **required**)
- `description` (`string`, **required**)

**Responses**:

- **`200`**: Response payload

---

## 9. Locations & GPS Tracking

*REST endpoints for driver coordinates and booking breadcrumbs (complemented by real-time WebSockets).*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **GET** | `/api/v1/locations/booking/{bookingId}` | Get live tracking data for a booking | 🔒 JWT | - |
| **POST** | `/api/v1/locations/driver` | Update driver live GPS coordinates | 🔒 JWT | `UpdateDriverLocationDto` |
| **GET** | `/api/v1/locations/driver/{driverId}` | Get current coordinates for a driver | 🔒 JWT | - |


### GET `/api/v1/locations/booking/{bookingId}`

**Description**: Get live tracking data for a booking

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `bookingId` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/locations/driver`

**Description**: Update driver live GPS coordinates

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`UpdateDriverLocationDto`):

- `latitude` (`number`, **required**) — Driver latitude
- `longitude` (`number`, **required**) — Driver longitude
- `heading` (`number`, optional) — Direction heading in degrees (0-360)
- `speed` (`number`, optional) — Speed in m/s
- `bookingId` (`string`, optional) — Active booking ID

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/locations/driver/{driverId}`

**Description**: Get current coordinates for a driver

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `driverId` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

## 10. Ratings & Feedback

*Customer and driver feedback scoring, rating submission, and historical driver ratings.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **POST** | `/api/v1/ratings` | Create a rating for a booking | 🔒 JWT | `CreateRatingDto` |
| **GET** | `/api/v1/ratings/booking/{bookingId}` | Get rating for a specific booking | 🔒 JWT | - |
| **GET** | `/api/v1/ratings/driver/{driverId}` | Get ratings for a driver | 🔒 JWT | - |


### POST `/api/v1/ratings`

**Description**: Create a rating for a booking

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`CreateRatingDto`):

- `bookingId` (`string`, **required**) — The booking ID
- `rating` (`number`, **required**) — Rating from 1 to 5
- `review` (`string`, optional) — Optional review text

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/ratings/booking/{bookingId}`

**Description**: Get rating for a specific booking

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `bookingId` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/ratings/driver/{driverId}`

**Description**: Get ratings for a driver

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `driverId` | `path` | `string` | **Yes** | - |
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |

**Responses**:

- **`200`**: Response payload

---

## 11. Coupons & Promotions

*Promotional discount validation, percentage/flat discounts, and coupon lifecycle.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **GET** | `/api/v1/coupons` | List all coupons | 🔒 JWT | - |
| **POST** | `/api/v1/coupons` | Create a new coupon | 🔒 JWT | `CreateCouponDto` |
| **GET** | `/api/v1/coupons/active` | List active coupons | 🔒 JWT | - |
| **POST** | `/api/v1/coupons/validate` | Validate a coupon | 🔒 JWT | `ValidateCouponDto` |
| **PATCH** | `/api/v1/coupons/{id}` | Update a coupon | 🔒 JWT | `UpdateCouponDto` |
| **DELETE** | `/api/v1/coupons/{id}` | Deactivate a coupon | 🔒 JWT | - |


### GET `/api/v1/coupons`

**Description**: List all coupons

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/coupons`

**Description**: Create a new coupon

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`CreateCouponDto`):

- `code` (`string`, **required**)
- `description` (`string`, optional)
- `discountType` (`string`, **required**) [Allowed: `PERCENTAGE, FLAT`]
- `discountValue` (`number`, **required**)
- `maxDiscount` (`number`, optional)
- `minBookingAmount` (`number`, optional)
- `maxUses` (`number`, optional)
- `validFrom` (`string`, **required**)
- `validTo` (`string`, **required**)

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/coupons/active`

**Description**: List active coupons

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/coupons/validate`

**Description**: Validate a coupon

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`ValidateCouponDto`):

- `code` (`string`, **required**)
- `bookingAmount` (`number`, **required**)

**Responses**:

- **`201`**: Response payload

---

### PATCH `/api/v1/coupons/{id}`

**Description**: Update a coupon

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Request Body** (`UpdateCouponDto`):

- `code` (`string`, optional)
- `description` (`string`, optional)
- `discountType` (`string`, optional) [Allowed: `PERCENTAGE, FLAT`]
- `discountValue` (`number`, optional)
- `maxDiscount` (`number`, optional)
- `minBookingAmount` (`number`, optional)
- `maxUses` (`number`, optional)
- `validFrom` (`string`, optional)
- `validTo` (`string`, optional)

**Responses**:

- **`200`**: Response payload

---

### DELETE `/api/v1/coupons/{id}`

**Description**: Deactivate a coupon

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

## 12. Notifications

*Push, SMS, and in-app alerts, read receipts, and administrative broadcast notifications.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **GET** | `/api/v1/notifications` | Get my notifications | 🔒 JWT | - |
| **POST** | `/api/v1/notifications/read-all` | Mark all notifications as read | 🔒 JWT | - |
| **POST** | `/api/v1/notifications/send` | Send a notification manually | 🔒 JWT | `SendNotificationDto` |
| **GET** | `/api/v1/notifications/unread-count` | Get unread notification count | 🔒 JWT | - |
| **PATCH** | `/api/v1/notifications/{id}/read` | Mark a notification as read | 🔒 JWT | - |


### GET `/api/v1/notifications`

**Description**: Get my notifications

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/notifications/read-all`

**Description**: Mark all notifications as read

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/notifications/send`

**Description**: Send a notification manually

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`SendNotificationDto`):

- `userId` (`string`, **required**)
- `title` (`string`, **required**)
- `body` (`string`, **required**)
- `channel` (`string`, **required**) [Allowed: `PUSH, SMS, EMAIL`]
- `metadata` (`object`, optional)

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/notifications/unread-count`

**Description**: Get unread notification count

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

### PATCH `/api/v1/notifications/{id}/read`

**Description**: Mark a notification as read

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

## 13. Support & Live Chat

*Help tickets, bi-directional live customer-admin chat messaging, and ticket resolution workflows.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **POST** | `/api/v1/support/chat/session` | Customer: Start or resume active live support chat session | 🔒 JWT | `StartChatSessionDto` |
| **POST** | `/api/v1/support/tickets` | Create a support ticket | 🔒 JWT | `CreateTicketDto` |
| **GET** | `/api/v1/support/tickets` | Admin: Get all support tickets with customer info | 🔒 JWT | - |
| **GET** | `/api/v1/support/tickets/active` | Customer: Get latest active support session | 🔒 JWT | - |
| **GET** | `/api/v1/support/tickets/my` | Get my support tickets | 🔒 JWT | - |
| **GET** | `/api/v1/support/tickets/{id}` | Get a specific ticket | 🔒 JWT | - |
| **PATCH** | `/api/v1/support/tickets/{id}` | Update a ticket | 🔒 JWT | `UpdateTicketDto` |
| **GET** | `/api/v1/support/tickets/{id}/messages` | Customer & Admin: Get message history for ticket | 🔒 JWT | - |
| **POST** | `/api/v1/support/tickets/{id}/messages` | Customer & Admin: Post a message to support chat | 🔒 JWT | `CreateMessageDto` |
| **PATCH** | `/api/v1/support/tickets/{id}/status` | Admin: Update ticket status or assignee | 🔒 JWT | - |


### POST `/api/v1/support/chat/session`

**Description**: Customer: Start or resume active live support chat session

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`StartChatSessionDto`):

- `bookingId` (`string`, optional)
- `subject` (`string`, optional)
- `initialMessage` (`string`, optional)

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/support/tickets`

**Description**: Create a support ticket

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`CreateTicketDto`):

- `bookingId` (`string`, optional)
- `subject` (`string`, **required**)
- `description` (`string`, **required**)
- `priority` (`string`, optional) [Allowed: `LOW, MEDIUM, HIGH, URGENT`]

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/support/tickets`

**Description**: Admin: Get all support tickets with customer info

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |
| `status` | `query` | `string` | No | - |
| `priority` | `query` | `string` | No | - |
| `assignedTo` | `query` | `string` | No | - |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/support/tickets/active`

**Description**: Customer: Get latest active support session

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `bookingId` | `query` | `string` | No | - |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/support/tickets/my`

**Description**: Get my support tickets

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `number` | No | Page number (1-indexed) |
| `limit` | `query` | `number` | No | Items per page |
| `cursor` | `query` | `string` | No | Cursor for cursor-based pagination |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/support/tickets/{id}`

**Description**: Get a specific ticket

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

### PATCH `/api/v1/support/tickets/{id}`

**Description**: Update a ticket

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Request Body** (`UpdateTicketDto`):

- `status` (`string`, **required**) [Allowed: `OPEN, IN_PROGRESS, RESOLVED, CLOSED`]
- `assignedTo` (`string`, optional)

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/support/tickets/{id}/messages`

**Description**: Customer & Admin: Get message history for ticket

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/support/tickets/{id}/messages`

**Description**: Customer & Admin: Post a message to support chat

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Request Body** (`CreateMessageDto`):

- `message` (`string`, **required**)

**Responses**:

- **`201`**: Response payload

---

### PATCH `/api/v1/support/tickets/{id}/status`

**Description**: Admin: Update ticket status or assignee

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

## 14. Admin Management & Analytics

*Platform administrative controls, user activation, audit logs, and analytical reports.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **GET** | `/api/v1/admin/audit-logs` | AdminController_getAuditLogs | 🔒 JWT | - |
| **POST** | `/api/v1/admin/broadcast` | AdminController_broadcast | 🔒 JWT | - |
| **GET** | `/api/v1/admin/overview` | AdminController_getOverview | 🔒 JWT | - |
| **POST** | `/api/v1/admin/users/{id}/activate` | AdminController_activateUser | 🔒 JWT | - |
| **POST** | `/api/v1/admin/users/{id}/deactivate` | AdminController_deactivateUser | 🔒 JWT | - |
| **GET** | `/api/v1/reports/booking-trends` | ReportsController_getBookingTrends | 🔒 JWT | - |
| **GET** | `/api/v1/reports/dashboard` | ReportsController_getDashboardStats | 🔒 JWT | - |
| **GET** | `/api/v1/reports/driver-performance` | ReportsController_getDriverPerformanceReport | 🔒 JWT | - |
| **GET** | `/api/v1/reports/revenue` | ReportsController_getRevenueReport | 🔒 JWT | - |


### GET `/api/v1/admin/audit-logs`

**Description**: AdminController_getAuditLogs

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `page` | `query` | `string` | No | - |
| `limit` | `query` | `string` | No | - |
| `actorId` | `query` | `string` | No | - |
| `action` | `query` | `string` | No | - |
| `entityType` | `query` | `string` | No | - |
| `entityId` | `query` | `string` | No | - |
| `from` | `query` | `string` | No | - |
| `to` | `query` | `string` | No | - |

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/admin/broadcast`

**Description**: AdminController_broadcast

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/admin/overview`

**Description**: AdminController_getOverview

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

### POST `/api/v1/admin/users/{id}/activate`

**Description**: AdminController_activateUser

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`201`**: Response payload

---

### POST `/api/v1/admin/users/{id}/deactivate`

**Description**: AdminController_deactivateUser

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/reports/booking-trends`

**Description**: ReportsController_getBookingTrends

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `from` | `query` | `string` | No | - |
| `to` | `query` | `string` | No | - |
| `interval` | `query` | `string` | No | - |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/reports/dashboard`

**Description**: ReportsController_getDashboardStats

**Access**: 🔒 Requires JWT Bearer Token

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/reports/driver-performance`

**Description**: ReportsController_getDriverPerformanceReport

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `from` | `query` | `string` | No | - |
| `to` | `query` | `string` | No | - |
| `interval` | `query` | `string` | No | - |

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/reports/revenue`

**Description**: ReportsController_getRevenueReport

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `from` | `query` | `string` | No | - |
| `to` | `query` | `string` | No | - |
| `interval` | `query` | `string` | No | - |

**Responses**:

- **`200`**: Response payload

---

## 15. Serviceable Operational Areas

*Operational polygon boundary definitions, city geofencing, and service availability checks.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **GET** | `/api/v1/serviceable-areas` | List all serviceable operational areas | 🔒 JWT | - |
| **POST** | `/api/v1/serviceable-areas` | Create a new serviceable area (Admin only) | 🔒 JWT | `CreateServiceableAreaDto` |
| **GET** | `/api/v1/serviceable-areas/check` | Check if a GPS coordinate is within active serviceable areas | 🔒 JWT | - |
| **GET** | `/api/v1/serviceable-areas/{id}` | Get a serviceable area by ID (Admin only) | 🔒 JWT | - |
| **PATCH** | `/api/v1/serviceable-areas/{id}` | Update an existing serviceable area (Admin only) | 🔒 JWT | `UpdateServiceableAreaDto` |
| **DELETE** | `/api/v1/serviceable-areas/{id}` | Delete a serviceable area (Admin only) | 🔒 JWT | - |
| **PATCH** | `/api/v1/serviceable-areas/{id}/toggle` | Toggle active status of a serviceable area (Admin only) | 🔒 JWT | - |


### GET `/api/v1/serviceable-areas`

**Description**: List all serviceable operational areas

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `onlyActive` | `query` | `string` | **Yes** | - |

**Responses**:

- **`200`**: List of operational areas returned successfully

---

### POST `/api/v1/serviceable-areas`

**Description**: Create a new serviceable area (Admin only)

**Access**: 🔒 Requires JWT Bearer Token

**Request Body** (`CreateServiceableAreaDto`):

- `name` (`string`, **required**) — City or area name
- `state` (`string`, **required**) — State or region name
- `centerLat` (`number`, **required**) — Center point latitude
- `centerLng` (`number`, **required**) — Center point longitude
- `radiusKm` (`number`, **required**) — Operational service radius around center in kilometers
- `isActive` (`boolean`, optional) *(default: `True`)* — Whether the area is currently active for accepting bookings

**Responses**:

- **`201`**: Response payload

---

### GET `/api/v1/serviceable-areas/check`

**Description**: Check if a GPS coordinate is within active serviceable areas

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `lat` | `query` | `number` | **Yes** | Latitude coordinate to check |
| `lng` | `query` | `number` | **Yes** | Longitude coordinate to check |
| `address` | `query` | `string` | No | Optional address text to check for localized operational rules |

**Responses**:

- **`200`**: Serviceability status returned

---

### GET `/api/v1/serviceable-areas/{id}`

**Description**: Get a serviceable area by ID (Admin only)

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

### PATCH `/api/v1/serviceable-areas/{id}`

**Description**: Update an existing serviceable area (Admin only)

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Request Body** (`UpdateServiceableAreaDto`):

- `name` (`string`, optional) — City or area name
- `state` (`string`, optional) — State or region name
- `centerLat` (`number`, optional) — Center point latitude
- `centerLng` (`number`, optional) — Center point longitude
- `radiusKm` (`number`, optional) — Operational service radius around center in kilometers
- `isActive` (`boolean`, optional) *(default: `True`)* — Whether the area is currently active for accepting bookings

**Responses**:

- **`200`**: Response payload

---

### DELETE `/api/v1/serviceable-areas/{id}`

**Description**: Delete a serviceable area (Admin only)

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

### PATCH `/api/v1/serviceable-areas/{id}/toggle`

**Description**: Toggle active status of a serviceable area (Admin only)

**Access**: 🔒 Requires JWT Bearer Token

**Parameters**:

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `id` | `path` | `string` | **Yes** | - |

**Responses**:

- **`200`**: Response payload

---

## 16. System Health & Probes

*Kubernetes/Docker liveness, readiness, and PostgreSQL/Redis dependency probes.*

| Method | Endpoint | Summary | Auth | Request Body |
|---|---|---|---|---|
| **GET** | `/api/v1/health` | HealthController_check | 🌐 Public | - |
| **GET** | `/api/v1/health/live` | HealthController_liveness | 🌐 Public | - |
| **GET** | `/api/v1/health/ready` | HealthController_readiness | 🌐 Public | - |


### GET `/api/v1/health`

**Description**: HealthController_check

**Access**: 🌐 Public Endpoint

**Responses**:

- **`200`**: The Health Check is successful
- **`503`**: The Health Check is not successful

---

### GET `/api/v1/health/live`

**Description**: HealthController_liveness

**Access**: 🌐 Public Endpoint

**Responses**:

- **`200`**: Response payload

---

### GET `/api/v1/health/ready`

**Description**: HealthController_readiness

**Access**: 🌐 Public Endpoint

**Responses**:

- **`200`**: The Health Check is successful
- **`503`**: The Health Check is not successful

---

## 17. Real-Time WebSocket Gateway (`/ws`)

Raftar Gaddi operates a clustered, real-time Socket.IO gateway powered by the Redis IO Adapter (`location.gateway.ts`).

### Connection & Handshake
- **URL**: `ws://localhost:3000/ws` or `wss://l7q2wkvw-3000.inc1.devtunnels.ms/ws`
- **Auth**: Pass JWT in `handshake.auth.token`, `headers['authorization']`, or query parameter `?token=...`.
- Connection rejects immediately if the token is missing or expired.
- On connection, drivers are indexed in Redis under `ws:client:<userId>`.

### Client Inbound Events (Subscribe)
| Event Name | Role | Payload | Description |
|---|---|---|---|
| `location:update` | DRIVER | `{ latitude: number, longitude: number, heading?: number, speed?: number, bookingId?: string }` | Updates driver's Redis geospatial coordinates. If active booking, persists to DB and streams live to customer room. |
| `driver:online` | DRIVER | `{}` | Signals driver availability to receive incoming dispatches. |
| `driver:offline` | DRIVER | `{}` | Removes driver from geospatial index and marks status OFFLINE. |
| `booking:join` | CUSTOMER / DRIVER / ADMIN | `{ bookingId: string }` | Subscribes client socket to the room `booking:<bookingId>` for live trip updates. |
| `support:join` | ALL | `{ ticketId: string }` | Joins the chat room `support:ticket:<ticketId>` for customer support session. |
| `support:leave` | ALL | `{ ticketId: string }` | Leaves the customer support session room. |

### Server Outbound Events (Emit)
| Event Name | Target Room / Client | Payload | Trigger / Description |
|---|---|---|---|
| `booking:request` | Eligible Nearby Drivers (Geofenced) | `{ bookingId, pickup, drop, fare, distance, vehicleType, expiresAt }` | Dispatched to drivers in progressive radii (10km -> 15km -> 25km) when customer requests a ride. |
| `booking:taken` | Broadcast to all drivers | `{ bookingId, assignedDriverId, status }` | Signals other drivers that the booking was accepted so their alert modals dismiss. |
| `driver:location` | `booking:<bookingId>` | `{ latitude, longitude, heading, speed, recordedAt }` | Real-time 1Hz driver GPS updates streamed to the customer tracking map. |
| `booking:status` | `booking:<bookingId>` | `{ bookingId, status, booking }` | Emitted when booking advances (`DRIVER_ARRIVED`, `TRIP_STARTED`, `COMPLETED`, `CANCELLED`). |
| `support:message` | `support:ticket:<ticketId>` | `{ id, message, senderId, senderRole, createdAt }` | Bi-directional live customer support message stream. |

---

## 18. Future API Development & Auto-Sync Protocol

Whenever you create a new API endpoint in the NestJS backend, follow this mandatory 4-step protocol to ensure it is immediately documented, typed, and synchronized:

### Step 1: Decorate the Controller Method
Add full NestJS Swagger decorators to your controller method:
```typescript
@Version('1')
@ApiBearerAuth('access-token') // Omit if public
@ApiOperation({ summary: 'Clear human-readable summary of the API' })
@ApiResponse({ status: 200, description: 'Success response description' })
@ApiResponse({ status: 400, description: 'Validation error description' })
@Post('your-new-endpoint')
async yourMethodName(@Body() dto: YourDtoClass) { ... }
```

### Step 2: Decorate DTO Properties
Ensure all request/response DTOs use `@ApiProperty()` or `@ApiPropertyOptional()` from `@nestjs/swagger` alongside `class-validator` decorators:
```typescript
export class YourDtoClass {
  @ApiProperty({ description: 'Customer identifier', example: 'c-1234' })
  @IsString()
  @IsNotEmpty()
  customerId: string;
}
```

### Step 3: Run the Auto-Documentation Command
With the backend server running, execute:
```bash
npm run docs:generate
```
This script automatically synchronizes with the live OpenAPI schema and updates `API_DOCUMENTATION.md` in both the backend repository and the project root.

### Step 4: Commit with Code Changes
Always commit the updated `API_DOCUMENTATION.md` alongside your controller and DTO files:
```bash
git add src/ API_DOCUMENTATION.md
git commit -m "feat(module): add your-new-endpoint and update API documentation"
```
