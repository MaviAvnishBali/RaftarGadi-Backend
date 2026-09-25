# Login API data-flow diagram

## Scope

RaftarGadi login is a phone-number OTP flow. It is not a password login:

1. The customer requests an OTP with `POST /api/v1/auth/send-otp`.
2. The customer submits the OTP with `POST /api/v1/auth/verify-otp`.
3. The API finds or creates the user, signs an access token, stores a
   hashed refresh-token record, and returns the authenticated user.
4. The Flutter app persists the user and lets the router move to `/home`.

## End-to-end data-flow diagram

```mermaid
flowchart TD
    U[Customer]
    P[PhoneScreen._requestOtp]
    O[OtpScreen._verify]
    AR[AuthRepository]
    ACR[ApiAuthRepository]
    API[ApiClient / Dio]
    HTTP[NestJS HTTP pipeline<br/>helmet, CORS, compression,<br/>versioning, ValidationPipe,<br/>global guards]
    AC[AuthController]
    AS[AuthService]
    CFG[AppConfigService]
    REDIS[(Redis<br/>otp:+phone<br/>otp_attempts:+phone)]
    US[UsersService]
    UR[UsersRepository]
    PRISMA[PrismaService]
    PG[(PostgreSQL<br/>users<br/>refresh_tokens)]
    JWT[JwtService]
    SC[SessionController.signIn]
    STORE[(Local KeyValueStore<br/>session_user)]
    ROUTER[GoRouter redirect]
    HOME[HomeShell / HomeScreen]
    ERR[Result.failure<br/>screen error message]

    U -->|phone number| P
    P -->|normalize +91 phone<br/>validate >= 10 digits| AR
    AR --> ACR
    ACR -->|POST /api/v1/auth/send-otp<br/>{phone}| API
    API --> HTTP
    HTTP -->|@Public route + DTO validation| AC
    AC -->|sendOtp(phone)| AS
    AS -->|otpLength, otpExpiry| CFG
    AS -->|set otp with TTL<br/>del attempts| REDIS
    REDIS -->|{message: OTP sent successfully}| AS
    AS --> AC --> HTTP --> API --> ACR --> AR
    AR -->|success| P
    P -->|go /login/otp?phone=...| O

    U -->|six-digit OTP| O
    O -->|phone, otp, role=CUSTOMER| AR
    AR --> ACR
    ACR -->|POST /api/v1/auth/verify-otp| API
    API --> HTTP
    HTTP -->|@Public route + DTO validation| AC
    AC -->|verifyOtp(phone, otp, role, deviceInfo, ip)| AS
    AS -->|get otp_attempts| REDIS
    AS -->|get otp unless dev bypass 123456| REDIS
    REDIS --> AS
    AS -->|invalid, expired, or max attempts| ERR
    AS -->|del OTP + attempts after success| REDIS
    AS -->|findOrCreateByPhone(phone, role)| US
    US -->|findByPhone| UR
    UR -->|user.findUnique| PRISMA
    PRISMA --> PG
    PG --> PRISMA --> UR --> US
    US -->|create if absent| UR
    UR -->|user.create| PRISMA --> PG
    US --> AS
    AS -->|generateAccessToken(user)| JWT
    AS -->|generateRefreshToken(user.id, deviceInfo, ip)<br/>uuidv4 + SHA-256 hash + 7-day expiry| PRISMA
    PRISMA -->|refreshToken.create| PG
    AS -->|AuthTokens: accessToken,<br/>refreshToken, expiresIn, user| AC
    AC --> HTTP --> API --> ACR
    ACR -->|AppUser.fromJson(json.user)| AR
    AR -->|Result.success(AppUser)| O
    O --> SC
    SC -->|write session_user| STORE
    SC -->|status=authenticated| ROUTER
    ROUTER --> HOME
    ERR -->|failure.message| O
```

## Request contracts

### 1. Request OTP

```http
POST /api/v1/auth/send-otp
Content-Type: application/json

{"phone":"+919876543210"}
```

Validation is performed by `SendOtpDto`: the phone is required, a string, and
must match the international phone-number pattern. On success:

```json
{"message":"OTP sent successfully"}
```

The current implementation logs the OTP outside production. It does not call
an SMS provider yet.

### 2. Verify OTP and login

```http
POST /api/v1/auth/verify-otp
Content-Type: application/json

{
  "phone": "+919876543210",
  "otp": "123456",
  "role": "CUSTOMER"
}
```

The successful response contains:

```json
{
  "accessToken": "<signed JWT>",
  "refreshToken": "<opaque token returned once>",
  "expiresIn": 3600,
  "user": {
    "id": "<uuid>",
    "phone": "+919876543210",
    "role": "CUSTOMER",
    "fullName": "Raftar User",
    "isPhoneVerified": true
  }
}
```

The Flutter repository currently maps only `response.user` into `AppUser`;
token persistence/refresh wiring should be added before treating this as a
production session implementation.

## Class, module, and function map

| Layer | Class/module | Functions involved | Responsibility |
|---|---|---|---|
| Flutter UI | `PhoneScreen` | `_normalizedPhone`, `_requestOtp` | Validate and normalize the phone; start the OTP request; route to OTP screen. |
| Flutter UI | `OtpScreen` | `_verify` | Validate six digits; submit OTP; display failures; pass the user to the session controller. |
| Flutter abstraction | `AuthRepository` | `requestOtp`, `verifyOtp` | Contract that keeps UI independent of transport. |
| Flutter data | `ApiAuthRepository` | `requestOtp`, `verifyOtp` | Build request bodies, call `ApiClient`, convert JSON to `AppUser`, wrap failures in `Result`. |
| Flutter DI | `authRepositoryProvider` | provider callback | Inject the `ApiClient` implementation into the repository. |
| Flutter session | `SessionController` | `signIn`, `bootstrap`, `signOut` | Persist `session_user` and publish authenticated/unauthenticated state. |
| Flutter navigation | `appRouterProvider` | `redirect` | React to session state and move authenticated users to the home shell. |
| API bootstrap | `bootstrap` | Nest app setup | Install global prefix/versioning, validation, security middleware, and listen on the configured port. |
| API composition | `AppModule` | module wiring | Register `AuthModule`, `UsersModule`, config, Redis, Prisma, JWT, and global guards. |
| Auth module | `AuthModule` | provider/module wiring | Inject `AuthController`, `AuthService`, `JwtModule`, `UsersModule`, Redis, config, and Prisma. |
| HTTP boundary | `AuthController` | `sendOtp`, `verifyOtp` | Expose public auth routes and pass DTO values plus request IP to the service. |
| Auth domain | `AuthService` | `sendOtp`, `verifyOtp` | Generate/check OTPs, enforce attempts, find/create users, issue tokens, and assemble `AuthTokens`. |
| Auth domain | `AuthService` private helpers | `generateRandomOtp`, `generateAccessToken`, `generateRefreshToken`, `hashToken` | Generate OTPs/JWTs, persist only a refresh-token hash, and hash opaque refresh tokens. |
| User domain | `UsersService` | `findByPhone`, `findOrCreateByPhone` | Find an existing phone account or create one with the requested role. |
| User persistence | `UsersRepository` | `findByPhone`, `create` | Translate user operations into Prisma calls. |
| Redis infrastructure | `RedisService` | `get`, `set`, `del` | Store OTP and failed-attempt keys with TTLs. |
| Database infrastructure | `PrismaService` | `$connect`, Prisma client calls | Connect to PostgreSQL and execute `user`/`refreshToken` queries. |
| Configuration | `AppConfigService` | `otpLength`, `otpExpiry`, `otpMaxAttempts`, `jwtAccessSecret`, `jwtAccessExpiration` | Supply environment-backed auth settings. |
| Database schema | Prisma `User`, `RefreshToken` | Prisma generated client methods | Store the account and hashed refresh-token session metadata. |

## Failure branches to study

- Invalid phone: `PhoneScreen` rejects it before a network call.
- Invalid request shape: `ValidationPipe` rejects the DTO before the controller.
- Missing/expired OTP: `AuthService.verifyOtp` raises `400`.
- Wrong OTP: attempts increment in Redis; after the configured limit, the API
  raises `429`.
- Database/Redis/network failure: the error travels through the repository
  `Result` boundary and is shown as `failure.message`.
- Authenticated navigation: `SessionController` changes state and
  `appRouterProvider.redirect` sends the user to `/home`.

## Code entry points

- Flutter: `apps/customer_app/lib/features/auth/phone_screen.dart`,
  `apps/customer_app/lib/features/auth/otp_screen.dart`,
  `packages/repositories/lib/src/auth/auth_repository.dart`
- API: `src/main.ts`, `src/modules/auth/controllers/auth.controller.ts`,
  `src/modules/auth/services/auth.service.ts`
- Persistence: `src/modules/users/services/users.service.ts`,
  `src/modules/users/repositories/users.repository.ts`,
  `src/config/redis.service.ts`, `src/database/prisma.service.ts`,
  `prisma/schema.prisma`
