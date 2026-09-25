# WebSocket Architecture

## Design
We use Socket.io integrated with NestJS Gateways for real-time bidirectional communication.

## Namespaces
- `/ws/driver`: For driver location updates and ride requests.
- `/ws/customer`: For customers tracking their active rides.

## Events
- `location:update` (Driver -> Server): Continuous GPS pings.
- `booking:request` (Server -> Driver): Broadcast new ride to nearby drivers.
- `booking:status` (Server -> Customer): Notify customer of ride state changes.

## Authentication
Connection requests must include a valid JWT in the handshake auth payload.
Connections without valid tokens are forcefully disconnected.

## Multi-instance Support
We use `@socket.io/redis-adapter`.
This allows broadcasting events across multiple Node.js instances seamlessly.
