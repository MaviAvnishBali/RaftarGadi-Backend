import { PaymentMethod, PaymentRecordStatus } from '@prisma/client';
import { Injectable } from '@nestjs/common';
import { PaymentsRepository } from '../repositories/payments.repository';
import { MockPaymentGateway } from './payment-gateway.service';

import { WebhookPayloadDto } from '../dto/webhook-payload.dto';
import { AppException } from '../../../common/exceptions/app.exception';
import { PaymentQueryDto } from '../dto/payment-query.dto';

import * as crypto from 'crypto';
import { ConfigService } from '@nestjs/config';
import { PrismaService } from '../../../database/prisma.service';

@Injectable()
export class PaymentsService {
  constructor(
    private readonly paymentsRepo: PaymentsRepository,
    private readonly paymentGateway: MockPaymentGateway,
    private readonly prisma: PrismaService,
    private readonly configService: ConfigService,
  ) {}

  private generateReference(): string {
    return `PAY-${Math.floor(100000 + Math.random() * 900000)}`;
  }

  async initiatePayment(bookingId: string, method: PaymentMethod, idempotencyKey?: string) {
    const reference = this.generateReference();

    const booking = await this.prisma.booking.findUnique({
      where: { id: bookingId },
    });
    if (!booking) {
      throw AppException.notFound('Booking not found');
    }

    const amount = Number(booking.finalFare || booking.estimatedFare || 100.0);

    let status: PaymentRecordStatus = PaymentRecordStatus.INITIATED;
    let orderData = null;

    if (method === PaymentMethod.CASH) {
      status = PaymentRecordStatus.SUCCESS;
    } else {
      orderData = await this.paymentGateway.createOrder(amount, reference);
    }

    const payment = await this.paymentsRepo.createPayment({
      bookingId,
      method,
      status,
      amount,
      paymentReference: reference,
      gatewayTransactionId: orderData?.orderId,
      idempotencyKey,
    });

    return { payment, checkoutUrl: orderData?.checkoutUrl };
  }

  async processWebhook(payload: WebhookPayloadDto) {
    const isProd = process.env.NODE_ENV === 'production';
    const webhookSecret = this.configService.get<string>('PAYMENT_WEBHOOK_SECRET');
    if (isProd && !webhookSecret) {
      throw new AppException('INTERNAL_SERVER_ERROR', 'Payment webhook secret must be configured in production', 500);
    }
    const secretKey = webhookSecret || 'raftargadi_secure_webhook_secret_2026';

    const dataToSign = `${payload.orderId}|${payload.transactionId}`;
    const expectedSignature = crypto
      .createHmac('sha256', secretKey)
      .update(dataToSign)
      .digest('hex');

    const providedBuffer = Buffer.from(payload.signature || '');
    const expectedBuffer = Buffer.from(expectedSignature);

    const isMatch =
      providedBuffer.length === expectedBuffer.length &&
      crypto.timingSafeEqual(providedBuffer, expectedBuffer);

    if (!isMatch) {
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

      // Update booking paymentStatus upon verified settlement
      await this.prisma.booking.update({
        where: { id: payment.bookingId },
        data: { paymentStatus: 'SUCCESS' },
      });
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
