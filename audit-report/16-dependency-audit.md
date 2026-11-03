# Raftar Gaddi – Backend Engineering Audit
# Document 16: Third-Party Dependencies & CVE Vulnerability Audit

**Audit Date:** November 2026  
**Auditor:** Application Security Specialist & Dependency Management Engineer  
**Component:** NPM Dependencies, `package.json`, `package-lock.json`, and CVE Security Advisories

---

## 1. Dependency Security Scan Summary

An automated vulnerability scan of the project's dependency tree via `npm audit` revealed **69 known vulnerabilities**:

```
┌─────────────────────────────────────────────────────────────┐
│ Total Vulnerabilities Detected: 69                          │
│ ├─ CRITICAL :  2 vulnerabilities                            │
│ ├─ HIGH     : 11 vulnerabilities                            │
│ ├─ MODERATE : 49 vulnerabilities                            │
│ └─ LOW      :  7 vulnerabilities                            │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Critical & High CVE Deep Dive

### 2.1 Critical Vulnerability 1: Arbitrary File Overwrite in `tar` (CWE-22)
- **Affected Package:** `tar <= 7.5.20`
- **Severity: CRITICAL (CVSS 9.4)**
- **Advisory:** GHSA-8mc6-4q26-w95x / CVE-2024-45338
- **Mechanics:** The `tar` package fails to properly sanitize symlinks and relative path components (`../`) when unpacking tar archives. A malicious archive can traverse directories and overwrite arbitrary files outside the extraction destination, leading to remote code execution (RCE) on the server.
- **Dependency Path:** Pulled transitively via `@openapitools/openapi-generator-cli` -> `@google/clasp` -> `tar`.
- **Remediation:** Update `tar` to `>= 7.5.3` via npm overrides or update the OpenAPI generator dependency.

---

### 2.2 High Vulnerability 2: Denial of Service in `multer`
- **Affected Package:** `multer <= 2.4.0`
- **Severity: HIGH (CVSS 7.5)**
- **Advisory:** CVE-2024-51754
- **Mechanics:** `multer` mishandles multipart boundary streams when parsing maliciously crafted multipart request bodies without strict file size or memory limits. This leads to unbounded memory consumption, event loop freezing, and Node.js process crashes.
- **Location in Code:** Used directly in `DriversController` for document uploads.
- **Remediation:** Upgrade `multer` to the latest patched version and enforce explicit `limits: { fileSize: 5 * 1024 * 1024, files: 1 }` on all file upload interceptors.

---

### 2.3 High Vulnerability 3: Regular Expression Denial of Service in `picomatch`
- **Affected Package:** `picomatch <= 2.3.1`
- **Severity: HIGH (CVSS 7.5)**
- **Advisory:** CVE-2024-4067
- **Mechanics:** Methodical backtracking in the regular expression parser of `picomatch` allows an attacker supplying crafted glob expressions to cause catastrophic backtracking, hanging the Node.js process at 100% CPU utilization.
- **Remediation:** Update `picomatch` to `>= 2.3.1` or `>= 3.0.1` via `package-lock.json` resolution.

---

## 3. Dependency Inventory & Hygiene Audit

### 3.1 Core Framework & Runtime Packages
| Package | Installed Version | Current Latest | Maintenance Status | Assessment |
|---|---|---|---|---|
| `@nestjs/core` | `^10.4.15` | `10.4.15` | Active | Modern NestJS 10 release. |
| `@prisma/client` | `^5.22.0` | `5.22.0` | Active | Stable. Prisma 6 is available but breaking. |
| `ioredis` | `^5.4.1` | `5.4.2` | Active | Stable Redis client. |
| `bullmq` | `^5.31.2` | `5.34.0` | Active | Modern queue library. |
| `socket.io` | `^4.8.1` | `4.8.1` | Active | Latest Socket.IO release. |
| `nestjs-pino` | `^4.1.0` | `4.2.0` | Active | Up to date. |

### 3.2 Unused & Dead Dependencies in `package.json`
Several packages are listed in `dependencies` but have no active code references in `src/`:
1. **`@nestjs/swagger-ui-express`:** Swagger is mounted using `@nestjs/swagger`'s built-in static handler; redundant secondary packages should be pruned.
2. **`@openapitools/openapi-generator-cli`:** A 50MB CLI utility packaged into `dependencies` rather than `devDependencies`. This dependency pulls the vulnerable `tar` library directly into the production container.

---

## 4. Remediation Action Plan

Execute the following phased dependency cleanup commands:

```bash
# 1. Move build-only CLI tools to devDependencies
npm install --save-dev @openapitools/openapi-generator-cli

# 2. Add npm overrides to package.json to force secure transitive versions
# In package.json:
# "overrides": {
#   "tar": "^7.5.3",
#   "picomatch": "^2.3.1",
#   "multer": "^2.4.1"
# }

# 3. Regenerate lockfile cleanly
npm audit fix
```
