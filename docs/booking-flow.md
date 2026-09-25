# Booking Flow

## Lifecycle

```mermaid
stateDiagram-v2
    [*] --> PENDING: User requests ride
    PENDING --> ACCEPTED: Driver accepts
    PENDING --> CANCELLED: Timeout/User cancels
    ACCEPTED --> IN_PROGRESS: Driver arrives & starts
    ACCEPTED --> CANCELLED: Driver/User cancels
    IN_PROGRESS --> COMPLETED: Trip finished
    COMPLETED --> [*]
    CANCELLED --> [*]
```

## Allowed Transitions
| Current State | Target State | Trigger |
|---------------|--------------|---------|
| PENDING | ACCEPTED | Driver match |
| PENDING | CANCELLED | User action / Timeout |
| ACCEPTED | IN_PROGRESS | Driver action |
| ACCEPTED | CANCELLED | User/Driver action |
| IN_PROGRESS | COMPLETED | Driver action |

## Cancellation Rules
- User can cancel for free before driver accepts.
- Cancellation fee applies if driver is en route.

## Driver Matching
See [Driver Matching Docs](./driver-matching.md)
