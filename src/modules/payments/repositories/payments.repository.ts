import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';
import { PaymentQueryDto } from '../dto/payment-query.dto';

@Injectable()
export class PaymentsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async createPayment(data: any) {
    return this.prisma.payment.create({ data });
  }

  async getPaymentById(id: string) {
    return this.prisma.payment.findUnique({ where: { id } });
  }

  async getPaymentByOrderId(paymentReference: string) {
    return this.prisma.payment.findUnique({ where: { paymentReference } });
  }

  async getPaymentsByBooking(bookingId: string) {
    return this.prisma.payment.findMany({ where: { bookingId }, orderBy: { createdAt: 'desc' } });
  }

  async updatePayment(id: string, data: any) {
    return this.prisma.payment.update({ where: { id }, data });
  }

  async getAllPayments(query: PaymentQueryDto) {
    const page = query.page || 1;
    const limit = query.limit || 10;
    const skip = (page - 1) * limit;

    const where: any = {};
    if (query.status) where.status = query.status;
    if (query.method) where.method = query.method;
    if (query.from || query.to) {
      where.createdAt = {};
      if (query.from) where.createdAt.gte = new Date(query.from);
      if (query.to) where.createdAt.lte = new Date(query.to);
    }

    const [items, total] = await Promise.all([
      this.prisma.payment.findMany({ where, skip, take: limit, orderBy: { createdAt: 'desc' } }),
      this.prisma.payment.count({ where }),
    ]);

    return { items, total, page, limit, totalPages: Math.ceil(total / limit) };
  }
}
