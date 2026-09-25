# RaftarGadi

Production-grade logistics platform inspired by Porter.

## Architecture Overview
Modular monolith built with NestJS, designed for clean boundaries and future microservices extraction.

## Tech Stack
- Node.js & NestJS
- PostgreSQL (Prisma ORM)
- Redis (Caching, GEO, WebSockets, BullMQ)
- Docker

## Prerequisites
- Node.js 20+
- PostgreSQL 16
- Redis 7
- Docker & Docker Compose

## Quick Start
```bash
git clone <repo>
cd RaftarGadi
npm install
cp .env.example .env
# Start DB and Redis
docker compose up -d
# Run migrations
npx prisma migrate dev
# Start dev server
npm run start:dev
```

## Available Scripts
- `npm run start:dev`: Start development server
- `npm run build`: Build production bundle
- `npm run test`: Run unit tests
- `npm run test:e2e`: Run E2E tests

## API Documentation
Available at `/api/docs` when the server is running.

## Project Structure
```
src/
  ├── modules/
  ├── common/
  ├── config/
  └── database/
```

## Environment Variables
| Variable | Description | Default |
|----------|-------------|---------|
| PORT | Server port | 3000 |
| DATABASE_URL | Postgres connection | - |
| REDIS_URL | Redis connection | redis://localhost:6379 |
| JWT_SECRET | JWT Secret | - |

## Docker Setup
Local development relies on `docker-compose.yml` to spin up PostgreSQL and Redis.

## Testing
Run `npm run test` for standard unit tests.

## Deployment
See `docs/deployment.md` for production deployment strategies.

## Contributing
Follow standard Git Flow and Conventional Commits.

## License
MIT
