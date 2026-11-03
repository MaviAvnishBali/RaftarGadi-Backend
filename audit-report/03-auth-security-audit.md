# Raftar Gaddi – Backend Engineering Audit
# Document 03: Authentication, Authorization & Identity Security Audit

**Audit Date:** November 2026  
**Auditor:** Application Security Specialist & Senior Backend Engineer  
**Component:** JWT Authentication, OTP Verification, RBAC/PBAC, Session Management, and Token Revocation

---

## 1. Authentication Architecture Overview

Authentication in Raftar Gaddi is phone-number-based, using One-Time Passwords (OTP) delivered via SMS, followed by stateless JSON Web Tokens (JWT) for session management:
- **Access Tokens:** Signed HMAC-SHA256 JWTs with a 1-hour lifespan (`expiresIn: 3600`).
- **Refresh Tokens:** Random UUIDv4 tokens hashed with SHA-256 and stored in the PostgreSQL `refresh_tokens` table with a 7-day lifespan.
- **Access Control:** Enforced globally by three guards in sequence:
  1. `JwtAuthGuard` ([`src/common/guards/jwt-auth.guard.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/common/guards/jwt-auth.guard.ts))
  2. `RolesGuard` ([`src/common/guards/roles.guard.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/common/guards/roles.guard.ts))
  3. `PermissionsGuard` ([`src/common/guards/permissions.guard.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/common/guards/permissions.guard.ts))

---

## 2. Critical Security Vulnerabilities

### 2.1 Universal Dev Auth Bypass & Auto-Provisioning Backdoor
In [`src/common/guards/jwt-auth.guard.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/common/guards/jwt-auth.guard.ts#L38-L63):

```typescript
// src/common/guards/jwt-auth.guard.ts: Lines 38-63
if (!token) {
  if (!this.configService.isProduction) {
    // In local development, automatically resolve or create a dev user matching the required role
    const targetRole = isAdminRoute ? 'ADMIN' : 'DRIVER';
    let devUser = await this.prisma.user.findFirst({
      where: { role: targetRole },
    });
    if (!devUser) {
      devUser = await this.prisma.user.create({
        data: {
          phone: isAdminRoute ? '+919999900000' : '+919999999999',
          name: isAdminRoute ? 'Operations Admin' : 'Demo Driver',
          role: targetRole,
          isVerified: true,
        },
      });
    }
    request.user = {
      sub: devUser.id,
      role: devUser.role,
      phone: devUser.phone,
    };
    return true;
  }
  throw new UnauthorizedException('Access token is required');
}
```

#### Vulnerability Assessment:
- **Severity: CRITICAL (CVSS 9.8)**
- **Mechanics:** Whenever `NODE_ENV` is not strictly set to `'production'` (such as in local dev, QA, testing, staging, or if an operator forgets to set `NODE_ENV` in a Docker container), **ANY HTTP request sent without an `Authorization` header is automatically authenticated as a super-privileged `ADMIN` or `DRIVER`!**
- **Impact:** An attacker on any non-production deployment (or misconfigured production deployment) can execute administrative actions (activate/deactivate users, broadcast notifications, alter pricing rules) with standard `curl` commands without any credentials.

---

### 2.2 Hardcoded Static Demo Admin Token Backdoor
In [`src/common/guards/jwt-auth.guard.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/common/guards/jwt-auth.guard.ts#L70-L93):

```typescript
// src/common/guards/jwt-auth.guard.ts: Lines 70-93
} catch {
  if (!this.configService.isProduction && (token === 'demo_admin_jwt_token_123' || token.startsWith('demo_admin_'))) {
    let adminUser = await this.prisma.user.findFirst({
      where: { role: 'ADMIN' },
    });
    if (!adminUser) {
      adminUser = await this.prisma.user.create({
        data: {
          phone: '+919999900000',
          name: 'Operations Admin',
          role: 'ADMIN',
          isVerified: true,
        },
      });
    }
    request.user = {
      sub: adminUser.id,
      role: adminUser.role,
      phone: adminUser.phone,
    };
    return true;
  }
  throw new UnauthorizedException('Invalid or expired access token');
}
```

#### Vulnerability Assessment:
- **Severity: CRITICAL**
- **Mechanics:** Hardcoded strings (`'demo_admin_jwt_token_123'` or any token starting with `demo_admin_`) bypass JWT signature verification entirely and grant full admin session state.
- **Remediation:** Remove all bypass logic, mock tokens, and dev auto-provisioning branches from `JwtAuthGuard`. Test environments must use validly signed test tokens generated with dedicated test secrets.

---

### 2.3 Cryptographically Insecure PRNG for OTP Generation
In [`src/modules/auth/services/auth.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/auth/services/auth.service.ts#L183-L190):

```typescript
// src/modules/auth/services/auth.service.ts: Lines 183-190
private generateRandomOtp(length: number): string {
  const chars = '0123456789';
  let otp = '';
  for (let i = 0; i < length; i++) {
    otp += chars[Math.floor(Math.random() * chars.length)];
  }
  return otp;
}
```

#### Vulnerability Assessment:
- **Severity: HIGH (CWE-338: Use of Cryptographically Weak Pseudo-Random Number Generator)**
- **Mechanics:** `Math.random()` in V8 uses the **XorShift128+** pseudo-random number generator. It is mathematically deterministic and not cryptographically secure (CSPRNG).
- **Exploitation:** Given a sequence of previously observed random values (from session IDs, booking numbers, or OTPs), an adversary can reconstruct the internal 128-bit state of the generator and predict future OTPs generated for any user phone number.
- **Remediation:** Replace with Node.js standard `crypto.randomInt`:
  ```typescript
  import * as crypto from 'crypto';

  private generateRandomOtp(length: number = 6): string {
    const min = Math.pow(10, length - 1);
    const max = Math.pow(10, length) - 1;
    return crypto.randomInt(min, max + 1).toString();
  }
  ```

---

### 2.4 OTP Rate-Limit Reset Flaw (Brute-Force Amplification)
In [`src/modules/auth/services/auth.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/auth/services/auth.service.ts#L25-L40):

```typescript
// src/modules/auth/services/auth.service.ts: Lines 25-40
async sendOtp(phone: string): Promise<{ message: string }> {
  const otpLength = this.configService.otpLength || 6;
  const otp = this.generateRandomOtp(otpLength);
  const otpKey = `otp:${phone}`;
  const attemptsKey = `otp_attempts:${phone}`;
  const ttl = this.configService.otpExpiry || 300;

  await this.redisService.set(otpKey, otp, ttl);
  await this.redisService.del(attemptsKey); // ⚠️ DELETES FAILED ATTEMPTS COUNTER!

  if (process.env.NODE_ENV !== 'production') {
    this.logger.log(`Development Mode - OTP for ${phone}: ${otp}`);
  }

  return { message: 'OTP sent successfully' };
}
```

#### Vulnerability Assessment:
- **Severity: HIGH**
- **Mechanics:** While `verifyOtp` limits attempts to 3 (`maxAttempts = 3`), `sendOtp` executes `await this.redisService.del(attemptsKey)` on every request.
- **Exploit Vector:** An attacker attempting to brute-force a victim's OTP submits 2 guesses. If incorrect, the attacker triggers `POST /api/v1/auth/send-otp`, which generates a new OTP and **deletes the failed attempt counter**. The attacker can repeat this cycle indefinitely without triggering the 429 lockout.
- **Additionally:** The universal development bypass `otp === '123456'` (line 60) exists in `verifyOtp`.

---

### 2.5 Complete Absence of Token Revocation & Blacklisting
The JWT implementation in [`JwtAuthGuard`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/common/guards/jwt-auth.guard.ts) validates tokens solely via `jwtService.verifyAsync()` against the signature and expiration time.
- **Missing Revocation Check:** When an admin suspends a driver (`POST /api/v1/drivers/:id/suspend`) or deactivates a user (`POST /api/v1/admin/users/:id/deactivate`), **the user's existing JWT remains 100% valid** until its 1-hour expiration.
- **No Token Blacklist:** The logout endpoint (`AuthService.logout`) only deletes the refresh token from PostgreSQL. The access token remains active in the wild.
- **Remediation:** Implement a Redis-backed token revocation list (JTI / token hash) or check `user.isSuspended / user.tokenVersion` in `JwtAuthGuard` or cache active session states in Redis.

---

## 3. RBAC & PBAC Authorization Audit

The platform defines three authorization roles in [`src/common/enums/index.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/common/enums/index.ts):
- `CUSTOMER`
- `DRIVER`
- `ADMIN` / `SUPER_ADMIN`

### Authorization Implementation Issues:
1. **Static Permissions Map:** In [`src/common/guards/permissions.guard.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/common/guards/permissions.guard.ts#L34), permissions are derived from a hardcoded in-memory `ROLE_PERMISSIONS` dictionary rather than a database-driven permissions model. Custom role delegation or granular admin privileges cannot be adjusted without code deployment.
2. **Missing Controller Role Annotations:** Multiple endpoints in `LocationsController` (e.g., `GET /locations/booking/:bookingId` and `GET /locations/driver/:driverId`) lack any `@Roles()` decorator, making them publicly callable by any authenticated user regardless of whether they have a relationship to the booking or driver.

---

## 4. Summary of Authentication & Identity Deficiencies

| Feature / Control | Current Implementation | Production Requirement | Status |
|---|---|---|---|
| **Access Token Signing** | HMAC-SHA256 (Secret from env) | RS256 / EdDSA with key rotation | ⚠️ Moderate |
| **Token Lifetime** | 1 hour (3600s) | 15 minutes (900s) for access token | ⚠️ Too Long |
| **Dev Auth Bypass** | Active if `NODE_ENV !== 'production'` | STRICTLY FORBIDDEN | 🔴 Critical |
| **Demo Tokens** | Hardcoded `demo_admin_jwt_token_123` | STRICTLY FORBIDDEN | 🔴 Critical |
| **OTP Randomness** | `Math.random()` | `crypto.randomInt` (CSPRNG) | 🔴 Insecure |
| **OTP Rate Limiting** | Resets on `sendOtp` | Sliding window rate limit per phone + IP | 🔴 Broken |
| **SMS Gateway Integration** | Mock/Logger only | Production SMS Provider (Twilio/MSG91) | 🔴 Non-Functional |
| **Token Revocation** | None (Access token cannot be revoked) | Redis Bloom filter / token blacklist | 🔴 Missing |
| **Refresh Token Family** | Single deletion | Token family tracking with theft detection | ⚠️ Basic |
