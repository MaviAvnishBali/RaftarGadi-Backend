import { PaymentMethod, PaymentRecordStatus } from '@prisma/client';
import { Injectable } from '@nestjs/common';
import { PaymentsRepository } from '../repositories/payments.repository';
import { MockPaymentGateway } from './payment-gateway.service';

import { WebhookPayloadDto } from '../dto/webhook-payload.dto';
import { AppException } from '../../../common/exceptions/app.exception';
import { PaymentQueryDto } from '../dto/payment-query.dto';

@Injectable()
export class PaymentsService {
  constructor(
    private readonly paymentsRepo: PaymentsRepository,
    private readonly paymentGateway: MockPaymentGateway,
  ) {}

  private generateReference(): string {
    return `PAY-${Math.floor(100000 + Math.random() * 900000)}`;
  }

  async initiatePayment(bookingId: string, method: PaymentMethod, idempotencyKey?: string) {
    const reference = this.generateReference();
    const mockAmount = 100.0;

    let status: PaymentRecordStatus = PaymentRecordStatus.INITIATED;
    let orderData = null;

    if (method === PaymentMethod.CASH) {
      status = PaymentRecordStatus.SUCCESS;
    } else {
      orderData = await this.paymentGateway.createOrder(mockAmount, reference);
    }

    const payment = await this.paymentsRepo.createPayment({
      bookingId,
      method,
      status,
      amount: mockAmount,
      paymentReference: reference,
      gatewayTransactionId: orderData?.orderId,
      idempotencyKey,
    });

    return { payment, checkoutUrl: orderData?.checkoutUrl };
  }

  async processWebhook(payload: WebhookPayloadDto) {
    if (payload.signature !== 'valid-signature') {
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
    } else {
      await this.paymentsRepo.updatePayment(payment.id, {
        status: PaymentRecordStatus.FAILED,
        gatewayTransactionId: payload.transactionId,
      });
    }
  }

  async getPaymentByBooking(bookingId: string) {
    return this.paymentsRepo.getPaymentsByBooking(bookingId);
  }

  async getPaymentById(id: string) {
    const payment = await this.paymentsRepo.getPaymentById(id);
    if (!payment) throw AppException.notFound('Payment not found');
    return payment;
  }

  async getAllPayments(query: PaymentQueryDto) {
    return this.paymentsRepo.getAllPayments(query);
  }

  async refundPayment(paymentId: string, reason: string) {
    const payment = await this.getPaymentById(paymentId);
    if (payment.status !== PaymentRecordStatus.SUCCESS) {
      throw new AppException('BAD_REQUEST', 'Only successful payments can be refunded', 400);
    }

    const refundData = await this.paymentGateway.refund(
      payment.gatewayTransactionId || '',
      Number(payment.amount),
    );

    return this.paymentsRepo.updatePayment(paymentId, {
      status: PaymentRecordStatus.REFUNDED,
      gatewayResponse: { refundReason: reason, refundId: refundData.refundId },
    });
  }
}
