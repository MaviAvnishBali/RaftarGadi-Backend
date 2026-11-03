# Raftar Gaddi – Backend Engineering Audit
# Document 14: Containerization, Docker & DevOps Infrastructure Audit

**Audit Date:** November 2026  
**Auditor:** Principal DevOps Engineer & Cloud Infrastructure Architect  
**Component:** Multi-Stage Dockerfile, Docker Compose, Port Exposure, Resource Quotas, and Process Management

---

## 1. Container & Infrastructure Topology

The containerization stack consists of:
- Multi-stage [`Dockerfile`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/Dockerfile) based on `node:20-alpine`.
- Orchestration via [`docker-compose.yml`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/docker-compose.yml) managing 4 services: `api`, `worker`, `postgres`, and `redis`.
- Development configuration via [`docker-compose.dev.yml`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/docker-compose.dev.yml).

---

## 2. Critical Containerization & DevOps Vulnerabilities

### 2.1 The Bloated Production Image Anti-Pattern
In [`Dockerfile`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/Dockerfile#L26-L30):

```dockerfile
# ─── Production Stage ────────────────────────────────────
FROM node:20-alpine AS production

WORKDIR /app
ENV NODE_ENV=production

RUN addgroup -g 1001 -S appgroup && \
    adduser -S appuser -u 1001 -G appgroup

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules  # ⚠️ COPIES ENTIRE BUILD TREE!
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/prisma ./prisma
```

#### Defect & Security Implications:
1. In Stage 1 (`builder`), `npm ci` installs **all** dependencies, including heavy `devDependencies`:
   - TypeScript compiler (`tsc`), `@types/*`, Jest test frameworks, ESLint, Prettier, Postman generators.
2. In Stage 2 (`production`), line 27 copies the **entire build `node_modules` directory directly into the production image**.
3. **Severe Operational Consequences:**
   - **Image Bloat:** The final container image inflates from ~180MB to over **1.2 Gigabytes**.
   - **Expanded Attack Surface:** Build tools, compilers, and test libraries (which frequently contain high-severity dev-only CVEs) are packaged into the production runtime environment.
   - **Deployment Lag:** Cloud CI/CD pipelines waste bandwidth and minutes pulling gigabyte-sized layers on every ECS/Kubernetes rolling deploy.
4. **Remediation:** Prune devDependencies before copying:
   ```dockerfile
   RUN npm prune --production
   ```

---

### 2.2 Direct PID 1 Execution & Broken Signal Forwarding
In [`Dockerfile`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/Dockerfile#L31-L35):
```dockerfile
USER appuser
EXPOSE 3000
CMD ["node", "dist/main"]
```
- **The Defect:** Node.js runs as **PID 1** directly inside the Linux container.
- **Why Node.js Must Not Run as PID 1:**
  1. Under the Linux kernel model, PID 1 does not inherit default signal handlers. When Docker sends `SIGTERM` (during container stop, autoscaling scale-down, or redeployment), Node.js ignores the signal unless explicit custom handlers exist.
  2. Orchestrators wait for a 30-second grace period and then issue `SIGKILL`, abruptly aborting in-flight HTTP requests and active database transactions.
  3. Node.js does not reap orphaned zombie child processes.
- **Remediation:** Install and use **`tini`** or **`dumb-init`** as the container entrypoint:
  ```dockerfile
  RUN apk add --no-cache tini
  ENTRYPOINT ["/sbin/tini", "--"]
  CMD ["node", "dist/main"]
  ```

---

### 2.3 Exposed Ports & Public Internet Access to Database and Redis
In [`docker-compose.yml`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/docker-compose.yml#L49-L50, #L64-L65):

```yaml
postgres:
  ports:
    - '5432:5432'   # ⚠️ EXPOSED TO 0.0.0.0 HOST NETWORK!

redis:
  ports:
    - '6379:6379'   # ⚠️ EXPOSED TO 0.0.0.0 HOST NETWORK!
```

#### Catastrophic Security Hazard:
- Binding `'5432:5432'` and `'6379:6379'` exposes PostgreSQL and Redis to **all network interfaces (`0.0.0.0`)**.
- If this Docker Compose file is executed on a standard cloud VPS (AWS EC2, DigitalOcean droplet, Hetzner instance):
  - **PostgreSQL and Redis become directly accessible over the public internet to any automated bot or attacker!**
  - Combined with hardcoded passwords in compose (`POSTGRES_PASSWORD=raftargadi_prod`), automated ransomware bots can connect, dump all customer data, wipe tables, and hold the database for ransom.
- **Remediation:** Remove public `ports:` declarations from database services. Services within `raftargadi-network` communicate via internal DNS names (`postgres:5432`, `redis:6379`) without exposing host ports.

---

### 2.4 Missing Container Resource Ceilings (Host Crash Vulnerability)
None of the services in [`docker-compose.yml`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/docker-compose.yml) define CPU or memory constraints.
- If a query causes a memory leak or a runaway BullMQ job runs wild, a single container can consume 100% of the host machine's RAM and CPU.
- The Linux kernel Out-Of-Memory (OOM) killer will terminate arbitrary host processes, crashing PostgreSQL or the entire virtual server.
- **Remediation:** Define explicit resource limits:
  ```yaml
  deploy:
    resources:
      limits:
        cpus: '2.0'
        memory: 2048M
      reservations:
        cpus: '0.5'
        memory: 512M
  ```

---

## 3. Summary of DevOps & Containerization Deficiencies

| Component | Current Implementation | Risk Level | Required Fix |
|---|---|---|---|
| **Production Node Modules** | Entire devDependencies tree included | 🔴 HIGH | Run `npm prune --production`. |
| **Process Init Manager** | `node` runs as PID 1 | 🔴 HIGH | Use `tini` as container entrypoint. |
| **Health Checks** | Missing in Dockerfile | ⚠️ MEDIUM | Add `HEALTHCHECK` checking `/api/v1/health`. |
| **Port Exposure** | 5432 & 6379 exposed to internet | 🔴 CRITICAL | Remove host port bindings from compose. |
| **Secrets Management** | Plaintext passwords in compose | 🔴 CRITICAL | Migrate to Docker secrets / Vault / AWS SSM. |
| **Resource Limits** | No CPU / Memory quotas | 🔴 HIGH | Define `deploy.resources.limits`. |
