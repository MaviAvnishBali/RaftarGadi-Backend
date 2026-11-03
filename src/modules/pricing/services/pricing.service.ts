import { Injectable } from '@nestjs/common';
import { PricingRepository } from '../repositories/pricing.repository';
import { CalculateFareDto } from '../dto/calculate-fare.dto';
import { CreatePricingRuleDto } from '../dto/create-pricing-rule.dto';
import { UpdatePricingRuleDto } from '../dto/update-pricing-rule.dto';
import { FareEstimate } from '../interfaces/fare-estimate.interface';
import { AppException } from '../../../common/exceptions/app.exception';
import { PaginationDto } from '../../../common/dto/pagination.dto';

import { PrismaService } from '../../../database/prisma.service';

@Injectable()
export class PricingService {
  constructor(
    private readonly pricingRepo: PricingRepository,
    private readonly prisma: PrismaService,
  ) {}

  private round(value: number): number {
    return Math.round(value * 100) / 100;
  }

  private calculateCoreFare(
    rule: any,
    distanceKm: number,
    durationMin: number,
    couponCode?: string,
  ): FareEstimate {
    const baseFare = Number(rule.baseFare);
    const distanceCharge = this.round(distanceKm * Number(rule.perKmCharge));
    const timeCharge = this.round(durationMin * Number(rule.perMinCharge));
    let subtotal = this.round(baseFare + distanceCharge + timeCharge);

    const surgeMultiplier = rule.surgeMultiplier ? Number(rule.surgeMultiplier) : 1.0;
    const surgeAmount = this.round(subtotal * surgeMultiplier - subtotal);
    subtotal = this.round(subtotal + surgeAmount);

    let discountAmount = 0;
    if (couponCode) {
      discountAmount = this.round(subtotal * 0.1); // Mock 10% discount
    }

    const platformFee = this.round(
      (subtotal - discountAmount) * (Number(rule.platformFeePercent) / 100),
    );
    const taxAmount = this.round(
      (subtotal - discountAmount + platformFee) * (Number(rule.taxPercent) / 100),
    );

    let totalFare = this.round(subtotal - discountAmount + platformFee + taxAmount);
    let minimumFareApplied = false;

    const minimumFare = Number(rule.minimumFare);
    if (totalFare < minimumFare) {
      totalFare = minimumFare;
      minimumFareApplied = true;
    }

    return {
      baseFare,
      distanceCharge,
      distanceFare: distanceCharge,
      timeCharge,
      timeFare: timeCharge,
      distanceKm,
      durationMinutes: durationMin,
      subtotal,
      surgeMultiplier,
      surgeAmount,
      platformFee,
      taxAmount,
      discountAmount,
      discount: discountAmount,
      totalFare,
      minimumFareApplied,
      currency: 'INR',
    };
  }

  async calculateEstimatedFare(dto: CalculateFareDto): Promise<FareEstimate> {
    const duration = dto.durationMin ?? dto.durationMinutes ?? 15;
    let targetVehicleTypeId = dto.vehicleTypeId;

    if (!targetVehicleTypeId && dto.vehicleType) {
      const vName = dto.vehicleType.toLowerCase();
      const allTypes = await this.prisma.vehicleType.findMany();
      const matched = allTypes.find((vt) => {
        const n = vt.name.toLowerCase();
        if (vName.includes('bike') && (n.includes('bike') || n.includes('2-wheeler'))) return true;
        if (vName.includes('auto') && (n.includes('3-wheeler') || n.includes('auto'))) return true;
        if (vName.includes('mini') && (n.includes('tata ace') || n.includes('chota'))) return true;
        if (vName.includes('truck') && (n.includes('407') || n.includes('bolero') || n.includes('truck'))) return true;
        return n.includes(vName);
      });
      targetVehicleTypeId = matched?.id;
    }

    const rule = await this.getActivePricingRule(targetVehicleTypeId, dto.city, dto.vehicleType);
    return this.calculateCoreFare(rule, dto.distanceKm, duration, dto.couponCode);
  }

  async calculateFinalFare(
    bookingId: string,
    actualDistanceKm: number,
    actualDurationMin: number,
  ): Promise<FareEstimate> {
    const rule = this.getDefaultPricingRule('bike');
    return this.calculateCoreFare(rule, actualDistanceKm, actualDurationMin);
  }

  async createPricingRule(dto: CreatePricingRuleDto) {
    return this.pricingRepo.createRule(dto);
  }

  async updatePricingRule(id: string, dto: UpdatePricingRuleDto) {
    const { dimensions, maxWeightKg, ...ruleData } = dto;
    const rule = await this.pricingRepo.updateRule(id, ruleData);
    if ((dimensions !== undefined || maxWeightKg !== undefined) && rule.vehicleTypeId) {
      await this.prisma.vehicleType.update({
        where: { id: rule.vehicleTypeId },
        data: {
          ...(dimensions !== undefined ? { dimensions } : {}),
          ...(maxWeightKg !== undefined ? { maxWeightKg } : {}),
        },
      });
    }
    return this.prisma.pricingRule.findUnique({
      where: { id },
      include: { vehicleType: true },
    });
  }

  async getPricingRules(query: PaginationDto) {
    return this.pricingRepo.getRules(query);
  }

  async getActivePricingRule(vehicleTypeId?: string, city: string = 'default', vehicleType?: string) {
    if (vehicleTypeId) {
      try {
        const rule = await this.pricingRepo.getActiveRule(vehicleTypeId, city);
        if (rule) return rule;
      } catch (_) {
        // Fall back to default
      }
    }
    return this.getDefaultPricingRule(vehicleType || vehicleTypeId);
  }

  private getDefaultPricingRule(hint?: string) {
    const h = (hint || '').toLowerCase();
    let baseFare = 40;
    let perKmCharge = 12;
    let perMinCharge = 1.5;
    let minimumFare = 40;

    if (h.includes('bike') || h.includes('2-wheeler')) {
      baseFare = 25;
      perKmCharge = 10;
      perMinCharge = 1.0;
      minimumFare = 25;
    } else if (h.includes('mini') || h.includes('tata ace') || h.includes('chota')) {
      baseFare = 150;
      perKmCharge = 20;
      perMinCharge = 2.0;
      minimumFare = 150;
    } else if (h.includes('truck') || h.includes('407') || h.includes('pickup')) {
      baseFare = 250;
      perKmCharge = 25;
      perMinCharge = 2.5;
      minimumFare = 250;
    }

    return {
      baseFare,
      perKmCharge,
      perMinCharge,
      minimumFare,
      platformFeePercent: 10,
      taxPercent: 5,
      surgeMultiplier: 1.0,
    };
  }

  async setSurge(vehicleTypeId: string | undefined, multiplier: number): Promise<void> {
    await this.pricingRepo.updateSurge(vehicleTypeId, multiplier);
  }
}
