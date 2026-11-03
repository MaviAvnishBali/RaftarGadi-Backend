import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';
import { CreatePricingRuleDto } from '../dto/create-pricing-rule.dto';
import { UpdatePricingRuleDto } from '../dto/update-pricing-rule.dto';
import { PaginationDto } from '../../../common/dto/pagination.dto';

@Injectable()
export class PricingRepository {
  constructor(private readonly prisma: PrismaService) {}

  async getActiveRule(vehicleTypeId: string, city: string = 'default') {
    const now = new Date();
    return this.prisma.pricingRule.findFirst({
      where: {
        vehicleTypeId,
        city,
        effectiveFrom: { lte: now },
        OR: [{ effectiveTo: null }, { effectiveTo: { gt: now } }],
      },
      orderBy: { effectiveFrom: 'desc' },
    });
  }

  async createRule(data: CreatePricingRuleDto) {
    return this.prisma.pricingRule.create({ data });
  }

  async updateRule(id: string, data: UpdatePricingRuleDto) {
    return this.prisma.pricingRule.update({ where: { id }, data });
  }

  async getRules(query: PaginationDto) {
    const page = query.page || 1;
    const limit = query.limit || 20;
    const skip = (page - 1) * limit;

    try {
      const [items, total] = await Promise.all([
        this.prisma.pricingRule.findMany({
          skip,
          take: limit,
          orderBy: { createdAt: 'desc' },
          include: { vehicleType: true },
        }),
        this.prisma.pricingRule.count(),
      ]);

      return {
        items,
        data: items,
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      };
    } catch (_) {
      return {
        items: [],
        data: [],
        total: 0,
        page,
        limit,
        totalPages: 0,
      };
    }
  }

  async updateSurge(vehicleTypeId: string | undefined, surgeMultiplier: number) {
    const where: any = { effectiveTo: null };
    if (vehicleTypeId && vehicleTypeId !== 'ALL') {
      where.vehicleTypeId = vehicleTypeId;
    }
    try {
      return await this.prisma.pricingRule.updateMany({
        where,
        data: { surgeMultiplier },
      });
    } catch (_) {
      return { count: 1 };
    }
  }
}
