# Authentication

## OTP Flow

The implementation-level data-flow diagram is in
[`docs/login-api-data-flow.md`](login-api-data-flow.md).

1. User requests an OTP with a phone number.
2. `AuthService.sendOtp` generates a plain OTP and stores it in Redis with a
   TTL (default five minutes), resetting the failed-attempt counter.
3. The current code logs the OTP outside production; an SMS provider is not
   wired yet.
4. User submits the OTP.
5. `AuthService.verifyOtp` checks Redis, deletes the OTP after success, finds or
   creates the user, and issues tokens.

## JWT Strategy
- **Access Token**: Short-lived (e.g., 15m), used for API access.
- **Refresh Token**: Long-lived (e.g., 7d), used to obtain new access tokens.

## Token Rotation
Refresh tokens are rotated upon use to prevent replay attacks.

## Session Management
Active sessions are tracked. Users can invalidate all sessions by changing their password or logging out from all devices.

## Guards and Decorators
- `@Public()`: Bypasses authentication.
- `@Roles(Role.ADMIN)`: Restricts route to specific roles.
- `@CurrentUser()`: Extracts the user payload from the request object.
