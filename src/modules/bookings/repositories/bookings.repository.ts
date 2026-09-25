import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';

@Injectable()
export class BookingsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: any) {
    return this.prisma.booking.create({
      data,
      include: {
        customer: true,
        driver: true,
        vehicleType: true,
        statusHistory: true,
      },
    });
  }

  async findById(id: string) {
    return this.prisma.booking.findUnique({
      where: { id },
      include: {
        customer: true,
        driver: true,
        vehicleType: true,
        statusHistory: {
          orderBy: { createdAt: 'asc' },
        },
      },
    });
  }

  async findByBookingNumber(bookingNumber: string) {
    return this.prisma.booking.findUnique({
      where: { bookingNumber },
      include: {
        customer: true,
        driver: true,
        vehicleType: true,
        statusHistory: {
          orderBy: { createdAt: 'asc' },
        },
      },
    });
  }

  async findMany(params: { skip?: number; take?: number; where?: any; orderBy?: any }) {
    return this.prisma.booking.findMany({
      ...params,
      include: {
        customer: true,
        driver: true,
        vehicleType: true,
      },
    });
  }

  async count(params: { where?: any }) {
    return this.prisma.booking.count(params);
  }

  async update(id: string, data: any) {
    return this.prisma.booking.update({
      where: { id },
      data,
      include: {
        customer: true,
        driver: true,
        vehicleType: true,
        statusHistory: {
          orderBy: { createdAt: 'asc' },
        },
      },
    });
  }
}
