import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';
import { CreateCouponDto } from '../dto/create-coupon.dto';
import { UpdateCouponDto } from '../dto/update-coupon.dto';

@Injectable()
export class CouponsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: CreateCouponDto) {
    return this.prisma.coupon.create({
      data: {
        ...data,
        code: data.code.toUpperCase(),
      },
    });
  }

  async findByCode(code: string) {
    return this.prisma.coupon.findUnique({
      where: { code: code.toUpperCase() },
    });
  }

  async findById(id: string) {
    return this.prisma.coupon.findUnique({
      where: { id },
    });
  }

  async findActive() {
    const now = new Date();
    return this.prisma.coupon.findMany({
      where: {
        isActive: true,
        validFrom: { lte: now },
        validTo: { gte: now },
      },
    });
  }

  async findAll(skip: number, take: number) {
    return this.prisma.coupon.findMany({
      skip,
      take,
      orderBy: { createdAt: 'desc' },
    });
  }

  async count() {
    return this.prisma.coupon.count();
  }

  async update(id: string, data: UpdateCouponDto) {
    return this.prisma.coupon.update({
      where: { id },
      data,
    });
  }

  async deactivate(id: string) {
    return this.prisma.coupon.update({
      where: { id },
      data: { isActive: false },
    });
  }

  async incrementUses(id: string) {
    return this.prisma.coupon.update({
      where: { id },
      data: { currentUses: { increment: 1 } },
    });
  }

  async recordRedemption(data: any) {
    return this.prisma.couponRedemption.create({
      data,
    });
  }
}
