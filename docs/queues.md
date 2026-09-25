# Background Queues (BullMQ)

## Architecture
BullMQ uses Redis to reliably process asynchronous background jobs.

## Queues
- **notification**: Push notifications and in-app alerts.
- **email**: Sending receipts and transactional emails.
- **sms**: OTPs and critical alerts.
- **invoice**: Generating PDF invoices for completed rides.
- **analytics**: Aggregating trip data.
- **cleanup**: Purging old logs and stale Redis keys.

## Workers
Configured in NestJS using `@nestjs/bullmq`. Workers scale horizontally with the application instances.

## Retry and Dead-letter
- Exponential backoff is configured for transient failures (e.g., SMS provider down).
- Failed jobs after max retries are moved to the `failed` set for manual inspection or dead-letter processing.

## Monitoring
BullMQ Dashboard can be integrated or exposed securely for admin monitoring.
