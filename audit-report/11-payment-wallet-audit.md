# Raftar Gaddi – Backend Engineering Audit
# Document 11: Payment Gateway, Driver Wallet & Financial Integrity Audit

**Audit Date:** November 2026  
**Auditor:** Application Security Specialist & Financial Systems Architect  
**Component:** Payment Processing, Razorpay/Stripe Webhooks, Driver Wallets, Withdrawals, and Double-Entry Ledger Integrity

---

## 1. Financial Systems Topology

The financial operations of Raftar Gaddi are governed by two modules:
1. **`PaymentsModule`** ([`src/modules/payments/services/payments.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/payments/services/payments.service.ts)): Handles customer payment orders, gateway integration, and webhook ingestion.
2. **`WalletsModule`** ([`src/modules/wallets/services/wallets.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/wallets/services/wallets.service.ts)): Handles driver earnings, platform commissions, bonuses, penalties, and withdrawal payouts.

---

## 2. Critical Financial Security Vulnerabilities

### 2.1 The Dummy Payment Webhook Signature Backdoor
In [`src/modules/payments/services/payments.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/payments/services/payments.service.ts#L47-L69):

```typescript
// src/modules/payments/services/payments.service.ts: Lines 47-69
async processWebhook(payload: WebhookPayloadDto) {
  if (payload.signature !== 'valid-signature') { // ⚠️ STATIC STRING BACKDOOR!
    throw new AppException('BAD_REQUEST', 'Invalid webhook signature', 400);
  }

  const payment = await this.paymentsRepo.getPaymentByOrderId(payload.orderId);
  if (!payment) {
    throw AppException.notFound('Payment not found');
  }

  if (payload.status === 'SUCCESS') {
    await this.paymentsRepo.updatePayment(payment.id, {
      status: PaymentRecordStatus.SUCCESS,
      gatewayTransactionId: payload.transactionId,
    });
    // Emit event to transition booking to COMPLETED here
  } ...
}
```

#### Vulnerability Assessment:
- **Severity: CRITICAL (CWE-347: Improper Verification of Cryptographic Signature)**
- **Mechanics:** Real payment gateways (Razorpay, Stripe, PayU) sign webhook payloads with an HMAC-SHA256 signature calculated from the raw HTTP request body and a shared secret key.
- **The Defect:** The backend checks whether `payload.signature === 'valid-signature'`!
- **Exploit Vector:** An attacker anywhere in the world can send an unauthenticated POST request:
  ```bash
  curl -X POST https://api.raftargadi.com/api/v1/payments/webhook \
    -H "Content-Type: application/json" \
    -d '{
      "orderId": "ORDER_12345",
      "transactionId": "TXN_FAKE_999",
      "signature": "valid-signature",
      "status": "SUCCESS"
    }'
  ```
  The backend immediately marks the order payment as **`SUCCESS`**, without a single rupee actually being deposited in the company's bank account.

---

### 2.2 Wallet Double-Spend & Negative Balance TOCTOU Exploit
In [`src/modules/wallets/services/wallets.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/wallets/services/wallets.service.ts#L152-L179):

```typescript
// src/modules/wallets/services/wallets.service.ts: Lines 152-179
async processWithdrawal(driverId: string, amount: number) {
  amount = this.round(amount);
  const wallet = await this.getWallet(driverId); // ⚠️ CHECK IS OUTSIDE TRANSACTION!

  if (Number(wallet.balance) < amount) {
    throw new AppException('ERROR', 'Insufficient balance', 400);
  }

  return this.prisma.$transaction(async (tx) => {
    const updatedWallet = await tx.driverWallet.update({
      where: { id: wallet.id },
      data: {
        balance: { decrement: amount }, // ⚠️ UNCONDITIONAL DECREMENT!
        totalWithdrawn: { increment: amount },
      },
    });

    return tx.walletTransaction.create({ ... });
  });
}
```

#### Time-of-Check to Time-of-Use (TOCTOU) Mechanics:
1. A driver has an account balance of **₹2,000.00**.
2. The driver fires two concurrent HTTP requests to withdraw ₹2,000.00 simultaneously:
   - **Thread 1:** `getWallet()` reads balance: ₹2,000.00. Check `2000 < 2000` is false. Proceeds to transaction.
   - **Thread 2:** `getWallet()` reads balance: ₹2,000.00. Check `2000 < 2000` is false. Proceeds to transaction.
   - **Transaction 1 executes:** `balance: { decrement: 2000 }`. Balance becomes **₹0.00**. Payout initiated.
   - **Transaction 2 executes:** `balance: { decrement: 2000 }`. Balance becomes **-₹2,000.00**! Second payout initiated.
3. The driver successfully extracts **₹4,000.00** from a ₹2,000.00 balance.
4. Because PostgreSQL lacks a `CHECK (balance >= 0)` constraint, the database happily stores the negative balance.
5. **Remediation:** Enforce balance validation directly inside the atomic SQL update:
   ```typescript
   const updated = await tx.driverWallet.updateMany({
     where: { id: wallet.id, balance: { gte: amount } },
     data: {
       balance: { decrement: amount },
       totalWithdrawn: { increment: amount },
     },
   });
   if (updated.count === 0) {
     throw new AppException('ERROR', 'Insufficient balance or concurrent transaction', 400);
   }
   ```

---

### 2.3 Hardcoded Flat ₹100 Payment Initiation
In [`src/modules/payments/services/payments.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/payments/services/payments.service.ts#L21-L38):

```typescript
// src/modules/payments/services/payments.service.ts: Lines 21-38
async initiatePayment(bookingId: string, method: PaymentMethod, idempotencyKey?: string) {
  const reference = this.generateReference();
  const mockAmount = 100.0; // ⚠️ HARDCODED 100 RUPEES!
  ...
```
- **Flaw:** The service completely ignores the booking's `estimatedFare` and `finalFare`.
- Whether a delivery is a 2 km bike ride costing ₹35 or a 50 km Tata 407 truck delivery costing ₹4,500, the system initiates a payment order for exactly **₹100.00**.

---

### 2.4 Automatic Unverified `paymentStatus = 'SUCCESS'` on Trip Completion
In [`src/modules/bookings/services/bookings.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/bookings/services/bookings.service.ts#L667-L677):
```typescript
const updated = await this.prisma.$transaction(async (tx) => {
  const result = await tx.booking.update({
    where: { id: bookingId },
    data: {
      status: 'TRIP_COMPLETED',
      paymentStatus: 'SUCCESS', // ⚠️ UNCONDITIONALLY SETS PAYMENT SUCCESS!
```
- When a driver clicks "Complete Trip", the backend sets `paymentStatus: 'SUCCESS'` regardless of whether the customer paid online, cash was handed over, or a payment gateway transaction even occurred.

---

### 2.5 Zero Platform Commission Deducted on Trip Completion
In [`src/modules/bookings/services/bookings.service.ts`](file:///home/hp/Applications/RaftarGadi/RaftarGadi-Backend/src/modules/bookings/services/bookings.service.ts#L710-L728):
```typescript
const updatedWallet = await tx.driverWallet.update({
  where: { id: wallet.id },
  data: {
    balance: { increment: finalFare }, // ⚠️ CREDITS 100% OF FARE!
    totalEarned: { increment: finalFare },
  },
});
```
- While `WalletsService` contains an unused helper `deductCommission()`, `BookingsService.completeTrip()` **credits 100% of the customer's fare directly into the driver's wallet**.
- The platform deducts zero commission (0%), operating at a massive net loss on every order after gateway fees and operational costs.

---

## 3. Summary of Financial Integrity Risks

| Financial Defect | Code Location | Risk Level | Direct Financial Impact |
|---|---|---|---|
| **Dummy Webhook Signature** | `payments.service.ts` (L48) | 🔴 CRITICAL | Anyone can fake payment success without paying. |
| **Withdrawal Double-Spend** | `wallets.service.ts` (L154) | 🔴 CRITICAL | Drivers can drain funds into negative balances. |
| **Hardcoded ₹100 Orders** | `payments.service.ts` (L23) | 🔴 CRITICAL | Incorrect charging on all non-₹100 rides. |
| **Premature Paid Status** | `bookings.service.ts` (L676) | 🔴 CRITICAL | Trips marked paid before gateway confirmation. |
| **0% Commission Deduction** | `bookings.service.ts` (L713) | 🔴 HIGH | Zero revenue collection for platform operations. |
| **Float Currency Math** | `schema.prisma` (L444) | 🔴 HIGH | Rounding errors across accounting ledgers. |
