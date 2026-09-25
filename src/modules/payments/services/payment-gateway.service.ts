import { Injectable } from '@nestjs/common';

export interface IPaymentGateway {
  createOrder(
    amount: number,
    reference: string,
  ): Promise<{ orderId: string; checkoutUrl?: string }>;
  verifyPayment(orderId: string): Promise<{ status: string; transactionId: string }>;
  refund(transactionId: string, amount: number): Promise<{ refundId: string }>;
}

@Injectable()
export class MockPaymentGateway implements IPaymentGateway {
  async createOrder(amount: number, reference: string) {
    return {
      orderId: `order_${Date.now()}`,
      checkoutUrl: `https://mock.gateway.com/checkout/${reference}`,
    };
  }

  async verifyPayment(orderId: string) {
    return {
      status: 'SUCCESS',
      transactionId: `txn_${Date.now()}`,
    };
  }

  async refund(transactionId: string, amount: number) {
    return {
      refundId: `ref_${Date.now()}`,
    };
  }
}
