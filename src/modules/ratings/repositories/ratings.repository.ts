import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';

@Injectable()
export class RatingsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async createRating(data: any) {
    return this.prisma.rating.create({ data });
  }

  async findByBookingId(bookingId: string) {
    return this.prisma.rating.findUnique({
      where: { bookingId },
    });
  }

  async findDriverRatings(driverId: string, skip: number, take: number) {
    return this.prisma.rating.findMany({
      where: { driverId },
      skip,
      take,
      orderBy: { createdAt: 'desc' },
    });
  }

  async countDriverRatings(driverId: string) {
    return this.prisma.rating.count({
      where: { driverId },
    });
  }
}
