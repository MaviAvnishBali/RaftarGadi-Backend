#!/usr/bin/env python3
"""
Raftar Gaddi API Documentation Generator

Fetches the OpenAPI/Swagger specification from the running NestJS server
and compiles a comprehensive, production-grade API documentation markdown file.

Usage:
  python3 scripts/generate_api_docs.py
  npm run docs:generate
"""

import urllib.request
import json
import os
import sys
from datetime import datetime

SWAGGER_URL = os.environ.get("SWAGGER_URL", "http://localhost:3000/api/docs-json")
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
BACKEND_DOC_PATH = os.path.join(SCRIPT_DIR, "../API_DOCUMENTATION.md")
ROOT_DOC_PATH = os.path.join(SCRIPT_DIR, "../../API_DOCUMENTATION.md")

TAG_METADATA = {
    "Auth": ("1. Authentication & Identity", "User login via Phone OTP, JWT generation, token refresh, and multi-device revocation."),
    "Customers": ("2. Customers", "Customer profile management and administrative customer directory."),
    "Drivers": ("3. Drivers & KYC", "Driver onboarding, real-time availability toggle, license/Aadhaar KYC submission, and verification."),
    "Vehicles": ("4. Vehicles & Fleet", "Fleet vehicle registration, specifications, dimension tiers, and geofenced vehicle discovery."),
    "Bookings": ("5. Bookings & Trip Lifecycle", "Full booking state machine: creation, geofenced dispatch, driver acceptance, arrival, OTP verification, and completion."),
    "Pricing": ("6. Pricing, Fares & Surge", "Distance/weight fare calculation, customizable pricing rules, and dynamic surge multipliers."),
    "Payments": ("7. Payments & Webhooks", "Payment initiation, payment gateway webhooks, transaction history, and refunds."),
    "Wallets": ("8. Wallets & Driver Payouts", "Driver wallet balances, earnings transactions, settlement ledger, and withdrawal requests."),
    "Locations": ("9. Locations & GPS Tracking", "REST endpoints for driver coordinates and booking breadcrumbs (complemented by real-time WebSockets)."),
    "Ratings": ("10. Ratings & Feedback", "Customer and driver feedback scoring, rating submission, and historical driver ratings."),
    "Coupons": ("11. Coupons & Promotions", "Promotional discount validation, percentage/flat discounts, and coupon lifecycle."),
    "Notifications": ("12. Notifications", "Push, SMS, and in-app alerts, read receipts, and administrative broadcast notifications."),
    "Support": ("13. Support & Live Chat", "Help tickets, bi-directional live customer-admin chat messaging, and ticket resolution workflows."),
    "Admin": ("14. Admin Management & Analytics", "Platform administrative controls, user activation, audit logs, and analytical reports."),
    "Serviceable Areas": ("15. Serviceable Operational Areas", "Operational polygon boundary definitions, city geofencing, and service availability checks."),
    "Health": ("16. System Health & Probes", "Kubernetes/Docker liveness, readiness, and PostgreSQL/Redis dependency probes.")
}

def fetch_json(url):
    req = urllib.request.Request(url, headers={"User-Agent": "RaftarGadi-DocsGen/1.0"})
    with urllib.request.urlopen(req, timeout=10) as response:
        return json.loads(response.read().decode("utf-8"))

def resolve_ref(ref, doc):
    if not ref or not ref.startswith("#/components/schemas/"):
        return None, None
    name = ref.replace("#/components/schemas/", "")
    schema = doc.get("components", {}).get("schemas", {}).get(name, {})
    return name, schema

def format_schema(schema, doc):
    if not schema:
        return "*(Any JSON object)*"
    if "$ref" in schema:
        name, resolved = resolve_ref(schema["$ref"], doc)
        if resolved:
            return format_schema(resolved, doc)
    
    properties = schema.get("properties", {})
    if not properties:
        return "*(Empty object or arbitrary key-value pairs)*"

    required_set = set(schema.get("required", []))
    lines = []
    for prop_name, prop in properties.items():
        is_req = "**required**" if prop_name in required_set else "optional"
        prop_type = prop.get("type", "any")
        if "$ref" in prop:
            prop_type = prop["$ref"].split("/")[-1]
        
        enum_vals = prop.get("enum")
        enum_str = f" [Allowed: `{', '.join(map(str, enum_vals))}`]" if enum_vals else ""
        desc_str = f" — {prop.get('description')}" if prop.get("description") else ""
        def_val = prop.get("default")
        def_str = f" *(default: `{def_val}`)*" if def_val is not None else ""
        lines.append(f"- `{prop_name}` (`{prop_type}`, {is_req}){enum_str}{def_str}{desc_str}")
    
    return "\n".join(lines)

def build_markdown(doc):
    paths = doc.get("paths", {})
    by_tag = {}

    for path_str, methods in paths.items():
        for method_str, op in methods.items():
            tags = op.get("tags") or ["General"]
            tag = tags[0]
            if tag not in by_tag:
                by_tag[tag] = []
            by_tag[tag].append({
                "method": method_str.upper(),
                "path": path_str,
                "summary": op.get("summary") or op.get("description") or op.get("operationId") or "No description",
                "parameters": op.get("parameters", []),
                "requestBody": op.get("requestBody"),
                "responses": op.get("responses", {}),
                "security": op.get("security", [])
            })

    total_endpoints = sum(len(items) for items in by_tag.values())
    today = datetime.now().strftime("%Y-%m-%d")

    out = []
    out.append("# Raftar Gaddi – Backend API Reference Documentation\n")
    out.append(f"> **Auto-Generated & Verified**: {today}  ")
    out.append("> **API Version**: `v1`  ")
    out.append(f"> **Total REST Endpoints**: **{total_endpoints}**  ")
    out.append("> **Total WebSocket Handlers**: **6 Events**  ")
    out.append("> **Interactive Swagger UI**: [`http://localhost:3000/api/docs`](http://localhost:3000/api/docs) or [`https://l7q2wkvw-3000.inc1.devtunnels.ms/api/docs`](https://l7q2wkvw-3000.inc1.devtunnels.ms/api/docs)  ")
    out.append("> **Raw OpenAPI JSON**: [`/api/docs-json`](http://localhost:3000/api/docs-json)\n")
    out.append("---\n")

    out.append("## Table of Contents\n")
    for tag, (title, _) in TAG_METADATA.items():
        count = len(by_tag.get(tag, []))
        anchor = title.lower().replace(".", "").replace("&", "").replace("/", "").replace(" ", "-")
        anchor = "-".join([w for w in anchor.split("-") if w])
        out.append(f"- [{title} ({count} Endpoints)](#{anchor})")
    out.append("- [17. Real-Time WebSocket Gateway (`/ws`)](#17-real-time-websocket-gateway-ws)")
    out.append("- [18. Future API Development & Auto-Sync Protocol](#18-future-api-development--auto-sync-protocol)\n")
    out.append("---\n")

    out.append("## Global API Conventions\n")
    out.append("### Base URLs")
    out.append("- **Local Development**: `http://localhost:3000/api/v1`")
    out.append("- **Staging / Public Tunnel**: `https://l7q2wkvw-3000.inc1.devtunnels.ms/api/v1`")
    out.append("- **WebSocket Gateway**: `wss://l7q2wkvw-3000.inc1.devtunnels.ms/ws` (or `ws://localhost:3000/ws`)\n")

    out.append("### Authentication & Authorization")
    out.append("All authenticated endpoints require an HTTP header:")
    out.append("```http\nAuthorization: Bearer <jwt_access_token>\n```")
    out.append("- **Roles**: `CUSTOMER`, `DRIVER`, `ADMIN`, `SUPER_ADMIN`.")
    out.append("- Tokens are issued via `POST /api/v1/auth/verify-otp` with a 15-minute access token TTL and a 7-day refresh token TTL.\n")

    out.append("### Standard Response Envelope")
    out.append("```json\n{\n  \"statusCode\": 200,\n  \"data\": { ... },\n  \"message\": \"Success\"\n}\n```\n")

    out.append("### Standard Error Envelope")
    out.append("```json\n{\n  \"statusCode\": 400,\n  \"message\": \"Validation failed: phone must be a valid phone number\",\n  \"error\": \"Bad Request\",\n  \"timestamp\": \"2026-11-05T12:00:00.000Z\",\n  \"path\": \"/api/v1/auth/send-otp\"\n}\n```\n")
    out.append("---\n")

    for tag, (title, desc) in TAG_METADATA.items():
        items = by_tag.get(tag, [])
        items.sort(key=lambda x: x["path"])
        out.append(f"## {title}\n")
        out.append(f"*{desc}*\n")

        # Summary table
        out.append("| Method | Endpoint | Summary | Auth | Request Body |")
        out.append("|---|---|---|---|---|")
        for ep in items:
            auth_str = "🔒 JWT" if len(ep["security"]) > 0 else "🌐 Public"
            req_body_name = "-"
            if ep["requestBody"]:
                schema = ep["requestBody"].get("content", {}).get("application/json", {}).get("schema", {})
                if "$ref" in schema:
                    req_body_name = f"`{schema['$ref'].split('/')[-1]}`"
                elif schema:
                    req_body_name = "`JSON Object`"
            out.append(f"| **{ep['method']}** | `{ep['path']}` | {ep['summary']} | {auth_str} | {req_body_name} |")
        out.append("\n")

        # Detailed cards
        for ep in items:
            auth_long = "🔒 Requires JWT Bearer Token" if len(ep["security"]) > 0 else "🌐 Public Endpoint"
            out.append(f"### {ep['method']} `{ep['path']}`\n")
            out.append(f"**Description**: {ep['summary']}\n")
            out.append(f"**Access**: {auth_long}\n")

            if ep["parameters"]:
                out.append("**Parameters**:\n")
                out.append("| Name | In | Type | Required | Description |")
                out.append("|---|---|---|---|---|")
                for p in ep["parameters"]:
                    p_type = p.get("schema", {}).get("type", "string")
                    p_req = "**Yes**" if p.get("required") else "No"
                    p_desc = p.get("description", "-")
                    out.append(f"| `{p.get('name')}` | `{p.get('in')}` | `{p_type}` | {p_req} | {p_desc} |")
                out.append("")

            if ep["requestBody"]:
                schema = ep["requestBody"].get("content", {}).get("application/json", {}).get("schema", {})
                dto_name = "JSON Payload"
                resolved = schema
                if "$ref" in schema:
                    dto_name, resolved = resolve_ref(schema["$ref"], doc)
                out.append(f"**Request Body** (`{dto_name}`):\n")
                out.append(format_schema(resolved, doc) + "\n")

            if ep["responses"]:
                out.append("**Responses**:\n")
                for code, resp in ep["responses"].items():
                    r_desc = resp.get("description") or "Response payload"
                    out.append(f"- **`{code}`**: {r_desc}")
                out.append("")

            out.append("---\n")

    # WebSocket Section
    out.append("## 17. Real-Time WebSocket Gateway (`/ws`)\n")
    out.append("Raftar Gaddi operates a clustered, real-time Socket.IO gateway powered by the Redis IO Adapter (`location.gateway.ts`).\n")
    out.append("### Connection & Handshake")
    out.append("- **URL**: `ws://localhost:3000/ws` or `wss://l7q2wkvw-3000.inc1.devtunnels.ms/ws`")
    out.append("- **Auth**: Pass JWT in `handshake.auth.token`, `headers['authorization']`, or query parameter `?token=...`.")
    out.append("- Connection rejects immediately if the token is missing or expired.")
    out.append("- On connection, drivers are indexed in Redis under `ws:client:<userId>`.\n")

    out.append("### Client Inbound Events (Subscribe)")
    out.append("| Event Name | Role | Payload | Description |")
    out.append("|---|---|---|---|")
    out.append("| `location:update` | DRIVER | `{ latitude: number, longitude: number, heading?: number, speed?: number, bookingId?: string }` | Updates driver's Redis geospatial coordinates. If active booking, persists to DB and streams live to customer room. |")
    out.append("| `driver:online` | DRIVER | `{}` | Signals driver availability to receive incoming dispatches. |")
    out.append("| `driver:offline` | DRIVER | `{}` | Removes driver from geospatial index and marks status OFFLINE. |")
    out.append("| `booking:join` | CUSTOMER / DRIVER / ADMIN | `{ bookingId: string }` | Subscribes client socket to the room `booking:<bookingId>` for live trip updates. |")
    out.append("| `support:join` | ALL | `{ ticketId: string }` | Joins the chat room `support:ticket:<ticketId>` for customer support session. |")
    out.append("| `support:leave` | ALL | `{ ticketId: string }` | Leaves the customer support session room. |\n")

    out.append("### Server Outbound Events (Emit)")
    out.append("| Event Name | Target Room / Client | Payload | Trigger / Description |")
    out.append("|---|---|---|---|")
    out.append("| `booking:request` | Eligible Nearby Drivers (Geofenced) | `{ bookingId, pickup, drop, fare, distance, vehicleType, expiresAt }` | Dispatched to drivers in progressive radii (10km -> 15km -> 25km) when customer requests a ride. |")
    out.append("| `booking:taken` | Broadcast to all drivers | `{ bookingId, assignedDriverId, status }` | Signals other drivers that the booking was accepted so their alert modals dismiss. |")
    out.append("| `driver:location` | `booking:<bookingId>` | `{ latitude, longitude, heading, speed, recordedAt }` | Real-time 1Hz driver GPS updates streamed to the customer tracking map. |")
    out.append("| `booking:status` | `booking:<bookingId>` | `{ bookingId, status, booking }` | Emitted when booking advances (`DRIVER_ARRIVED`, `TRIP_STARTED`, `COMPLETED`, `CANCELLED`). |")
    out.append("| `support:message` | `support:ticket:<ticketId>` | `{ id, message, senderId, senderRole, createdAt }` | Bi-directional live customer support message stream. |\n")
    out.append("---\n")

    out.append("## 18. Future API Development & Auto-Sync Protocol\n")
    out.append("Whenever you create a new API endpoint in the NestJS backend, follow this mandatory 4-step protocol to ensure it is immediately documented, typed, and synchronized:\n")

    out.append("### Step 1: Decorate the Controller Method")
    out.append("Add full NestJS Swagger decorators to your controller method:")
    out.append("```typescript")
    out.append("@Version('1')")
    out.append("@ApiBearerAuth('access-token') // Omit if public")
    out.append("@ApiOperation({ summary: 'Clear human-readable summary of the API' })")
    out.append("@ApiResponse({ status: 200, description: 'Success response description' })")
    out.append("@ApiResponse({ status: 400, description: 'Validation error description' })")
    out.append("@Post('your-new-endpoint')")
    out.append("async yourMethodName(@Body() dto: YourDtoClass) { ... }")
    out.append("```\n")

    out.append("### Step 2: Decorate DTO Properties")
    out.append("Ensure all request/response DTOs use `@ApiProperty()` or `@ApiPropertyOptional()` from `@nestjs/swagger` alongside `class-validator` decorators:")
    out.append("```typescript")
    out.append("export class YourDtoClass {")
    out.append("  @ApiProperty({ description: 'Customer identifier', example: 'c-1234' })")
    out.append("  @IsString()")
    out.append("  @IsNotEmpty()")
    out.append("  customerId: string;")
    out.append("}")
    out.append("```\n")

    out.append("### Step 3: Run the Auto-Documentation Command")
    out.append("With the backend server running, execute:")
    out.append("```bash")
    out.append("npm run docs:generate")
    out.append("```")
    out.append("This script automatically synchronizes with the live OpenAPI schema and updates `API_DOCUMENTATION.md` in both the backend repository and the project root.\n")

    out.append("### Step 4: Commit with Code Changes")
    out.append("Always commit the updated `API_DOCUMENTATION.md` alongside your controller and DTO files:")
    out.append("```bash")
    out.append("git add src/ API_DOCUMENTATION.md")
    out.append("git commit -m \"feat(module): add your-new-endpoint and update API documentation\"")
    out.append("```\n")

    return "\n".join(out)

def main():
    print(f"📡 Fetching OpenAPI schema from {SWAGGER_URL}...")
    try:
        doc = fetch_json(SWAGGER_URL)
        title = doc.get("info", {}).get("title", "RaftarGadi API")
        version = doc.get("info", {}).get("version", "1.0")
        print(f"✅ Fetched OpenAPI spec: {title} v{version}")

        markdown = build_markdown(doc)

        with open(BACKEND_DOC_PATH, "w", encoding="utf-8") as f:
            f.write(markdown)
        print(f"📄 Wrote backend documentation to: {BACKEND_DOC_PATH}")

        with open(ROOT_DOC_PATH, "w", encoding="utf-8") as f:
            f.write(markdown)
        print(f"📄 Wrote root documentation to: {ROOT_DOC_PATH}")

        # Clean up any broken script
        old_js = os.path.join(SCRIPT_DIR, "generate-api-docs.js")
        if os.path.exists(old_js):
            os.remove(old_js)

        print("🎉 API Documentation generated successfully!")
    except Exception as e:
        print(f"❌ Failed to generate API documentation: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
