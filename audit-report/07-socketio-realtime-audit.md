# Raftar Gaddi – Backend Engineering Audit
# Document 07: Socket.IO & Real-Time Gateway Security Audit

**Audit Date:** November 2026  
**Auditor:** Application Security Specialist & Senior Real-Time Systems Engineer  
**Component:** Socket.IO Gateway, WebSocket Handshake Authentication, Room Authorization, Global Broadcasting, and Multi-Instance Clustering

---

## 1. Real-Time Gateway Architecture Overview

Real-time communication in Raftar Gaddi is implemented using **Socket.IO** via `@nestjs/websockets` in `LocationGateway` ([`src/modules/locations/gateways/location.gateway.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/locations/gateways/location.gateway.ts)).
It handles:
- Live GPS telemetry ingestion from drivers (`location:update`)
- Real-time driver location streaming to customers (`driver:location`)
- Order status notifications (`booking:status`, `booking:taken`, `booking:cancelled`)
- Support ticketing chat rooms (`support:join`, `support:message`)

---

## 2. Critical Real-Time Security & Privacy Vulnerabilities

### 2.1 Unsigned JWT Decode Fallback (Total WebSocket Impersonation)
In [`src/modules/locations/gateways/location.gateway.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/locations/gateways/location.gateway.ts#L50-L61):

```typescript
// src/modules/locations/gateways/location.gateway.ts: Lines 50-61
let payload: any;
try {
  payload = this.jwtService.verify(token);
} catch (_) {
  payload = this.jwtService.decode(token); // ⚠️ CRITICAL VULNERABILITY!
}

if (!payload || !payload.sub) {
  this.logger.warn(`Client ${client.id} rejected: Invalid JWT token`);
  client.disconnect();
  return;
}

client.data.user = payload;
```

#### Vulnerability Assessment:
- **Severity: CRITICAL (CVSS 10.0 - Full Authentication Bypass)**
- **Mechanics:**
  - `this.jwtService.verify(token)` checks the cryptographic HMAC signature against the server's secret.
  - If the token signature is invalid, expired, or forged, `verify()` throws an error.
  - The `catch (_)` block catches the error and falls back to **`this.jwtService.decode(token)`**, which merely base64-decodes the JSON payload **without verifying the cryptographic signature!**
- **Exploit Vector:** An attacker crafts a forged JWT containing:
  ```json
  { "sub": "admin-user-uuid", "role": "ADMIN", "phone": "+919999900000" }
  ```
  The attacker connects to `wss://api.raftargadi.com/ws` with this forged token. The signature verification fails, the catch block decodes the raw JSON, sets `client.data.user = payload`, and grants the attacker full authenticated access as an Administrator!

---

### 2.2 Global Data Leakage via `this.server.emit` (Massive PII Breach)
In [`src/modules/locations/gateways/location.gateway.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/locations/gateways/location.gateway.ts#L409-L449):

```typescript
// src/modules/locations/gateways/location.gateway.ts: Lines 409-449
@OnEvent('booking.status')
handleBookingStatus(payload: { bookingId: string; status: string; booking: any }): void {
  this.logger.log(`Broadcasting booking:status for booking ${payload?.bookingId}: ${payload?.status}`);
  this.sendToBookingRoom(payload.bookingId, 'booking:status', payload);
  this.server.emit('booking:status', payload); // ⚠️ LEAKS TO ALL CONNECTED CLIENTS!
}

@OnEvent('booking.cancelled')
handleBookingCancelled(payload: { bookingId: string; cancelledBy: string; reason?: string }): void {
  this.sendToBookingRoom(payload.bookingId, 'booking:status', ...);
  this.server.emit('booking:cancelled', payload); // ⚠️ LEAKS TO ALL CLIENTS!
}

@OnEvent('support.message')
handleSupportMessage(payload: { ticketId: string; message: any }): void {
  this.server.to(`support:ticket:${payload.ticketId}`).emit('support:message', payload.message);
  this.server.emit('support:admin_update', payload); // ⚠️ LEAKS CHATS TO ALL CLIENTS!
}
```

#### Privacy & Security Breach Impact:
- In Socket.IO, **`this.server.emit()` broadcasts the event to EVERY connected socket on the platform** (all active customers, drivers, and anonymous attackers connected to `/ws`).
- **Data Leaked to the Entire User Base in Real-Time:**
  - Customer full names, phone numbers, pickup addresses, and destination coordinates.
  - Driver names, vehicle registration numbers, and live GPS locations.
  - Confidential customer-support text messages and disputes (`support:admin_update`).
- **Remediation:** Remove all occurrences of `this.server.emit()`. Events must be strictly dispatched to authorized private rooms:
  ```typescript
  this.server.to(`booking:${payload.bookingId}`).emit('booking:status', payload);
  ```

---

### 2.3 Unauthenticated Support Room Eavesdropping
In [`src/modules/locations/gateways/location.gateway.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/locations/gateways/location.gateway.ts#L427-L434):

```typescript
// src/modules/locations/gateways/location.gateway.ts: Lines 427-434
@SubscribeMessage('support:join')
handleSupportJoin(client: Socket, data: { ticketId: string }) {
  if (data?.ticketId) {
    client.join(`support:ticket:${data.ticketId}`);
    this.logger.log(`Socket ${client.id} joined support room support:ticket:${data.ticketId}`);
    return { success: true, room: `support:ticket:${data.ticketId}` };
  }
}
```

#### Vulnerability Assessment:
- **Severity: HIGH (Broken Object Level Authorization)**
- **Mechanics:** Any connected client can emit `support:join` with any `ticketId`.
- **Zero Authorization Checks:** The gateway does not check whether `client.data.user` is the creator of the ticket or an authorized support agent.
- **Impact:** Any user can listen to other customers' private support chats, grievance submissions, and sensitive account dispute details.

---

### 2.4 Multi-Instance Clustering Failure: Unattached Redis IO Adapter
`package.json` includes:
```json
"@socket.io/redis-adapter": "^8.3.0"
```
However, in [`src/main.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/main.ts), NestJS's default WebSocket adapter is used:
- **Omission:** `app.useWebSocketAdapter(new RedisIoAdapter(app))` is **never executed**.
- **Impact:** Socket.IO runs on the **default in-memory adapter**.
- **Cluster Breakdown:**
  - When deployed across 2 or more replicas (ECS tasks, Kubernetes pods, or Docker containers), a driver connected to Replica 1 emitting location updates will NEVER reach a customer connected to Replica 2!
  - Real-time tracking fails completely in any multi-instance or auto-scaling environment.

---

## 3. Summary of WebSocket Gateway Vulnerabilities

| Vulnerability | File & Location | Severity | Exploitation Impact |
|---|---|---|---|
| **Unsigned JWT Decode** | `location.gateway.ts` (L51-56) | 🔴 CRITICAL | Anyone can forge arbitrary admin/driver sessions. |
| **Global Data Broadcast** | `location.gateway.ts` (L413, 424, 448) | 🔴 CRITICAL | Customer PII, trip coordinates, and chat leaked platform-wide. |
| **Support Room Hijacking** | `location.gateway.ts` (L427-434) | 🔴 HIGH | Unauthorized eavesdropping on support tickets. |
| **Unattached Redis Adapter** | `main.ts` | 🔴 HIGH | Zero multi-instance scalability; tracking broken on cluster. |
| **Wildcard CORS** | `location.gateway.ts` (L20) | ⚠️ MEDIUM | Cross-Site WebSocket Hijacking (CSWSH) risk. |
