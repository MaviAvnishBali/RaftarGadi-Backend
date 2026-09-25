import { Injectable } from '@nestjs/common';
import { PricingRepository } from '../repositories/pricing.repository';
import { CalculateFareDto } from '../dto/calculate-fare.dto';
import { CreatePricingRuleDto } from '../dto/create-pricing-rule.dto';
import { UpdatePricingRuleDto } from '../dto/update-pricing-rule.dto';
import { FareEstimate } from '../interfaces/fare-estimate.interface';
import { AppException } from '../../../common/exceptions/app.exception';
import { PaginationDto } from '../../../common/dto/pagination.dto';

@Injectable()
export class PricingService {
  constructor(private readonly pricingRepo: PricingRepository) {}

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
      timeCharge,
      subtotal,
      surgeMultiplier,
      surgeAmount,
      platformFee,
      taxAmount,
      discountAmount,
      totalFare,
      minimumFareApplied,
      currency: 'INR',
    };
  }

  async calculateEstimatedFare(dto: CalculateFareDto): Promise<FareEstimate> {
    const rule = await this.getActivePricingRule(dto.vehicleTypeId, dto.city);
    return this.calculateCoreFare(rule, dto.distanceKm, dto.durationMin, dto.couponCode);
  }

  async calculateFinalFare(
    bookingId: string,
    actualDistanceKm: number,
    actualDurationMin: number,
  ): Promise<FareEstimate> {
    const dummyVehicleTypeId = '00000000-0000-0000-0000-000000000000';
    const rule = await this.getActivePricingRule(dummyVehicleTypeId, 'default');
    return this.calculateCoreFare(rule, actualDistanceKm, actualDurationMin);
  }

  async createPricingRule(dto: CreatePricingRuleDto) {
    return this.pricingRepo.createRule(dto);
  }

  async updatePricingRule(id: string, dto: UpdatePricingRuleDto) {
    return this.pricingRepo.updateRule(id, dto);
  }

  async getPricingRules(query: PaginationDto) {
    return this.pricingRepo.getRules(query);
  }

  async getActivePricingRule(vehicleTypeId: string, city: string = 'default') {
    const rule = await this.pricingRepo.getActiveRule(vehicleTypeId, city);
    if (!rule) {
      throw new AppException('ERROR', 'Pricing rule not found for the given criteria', 404);
    }
    return rule;
  }

  async setSurge(vehicleTypeId: string, multiplier: number): Promise<void> {
    await this.pricingRepo.updateSurge(vehicleTypeId, multiplier);
  }
}
