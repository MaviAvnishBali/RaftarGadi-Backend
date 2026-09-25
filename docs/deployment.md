# Deployment

## Docker Deployment
The app is containerized using a multi-stage Dockerfile to keep the image lean.
```bash
docker build -t raftargadi-api .
docker run -p 3000:3000 --env-file .env raftargadi-api
```

## Environment Config
Production environments rely on injected environment variables.
Avoid committing `.env` files.

## Migrations
In production, run migrations explicitly during the deployment pipeline (e.g., CI/CD step):
`npx prisma migrate deploy`

## Health Checks
- `GET /health`: Basic API liveness.
- Includes checks for Postgres and Redis connectivity.

## Scaling
- **Stateless API**: Can run multiple replicas behind a Load Balancer.
- **WebSockets**: Redis Adapter ensures multi-instance compatibility.
- **Workers**: BullMQ handles concurrency safely across replicas.

## Monitoring
Metrics exposed for Prometheus at `/metrics` (if configured).
Grafana dashboards can be used to visualize API latency, queue length, and error rates.
