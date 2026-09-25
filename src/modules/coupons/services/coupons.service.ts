import { Injectable, HttpStatus } from '@nestjs/common';
import { CouponsRepository } from '../repositories/coupons.repository';
import { CreateCouponDto, DiscountType } from '../dto/create-coupon.dto';
import { UpdateCouponDto } from '../dto/update-coupon.dto';
import { AppException } from '../../../common/exceptions/app.exception';
import { PaginationDto } from '../../../common/dto/pagination.dto';

@Injectable()
export class CouponsService {
  constructor(private readonly couponsRepo: CouponsRepository) {}

  async createCoupon(dto: CreateCouponDto) {
    const existing = await this.couponsRepo.findByCode(dto.code);
    if (existing) {
      throw AppException.conflict('Coupon code already exists');
    }
    return this.couponsRepo.create(dto);
  }

  async validateCoupon(code: string, bookingAmount: number) {
    const coupon = await this.couponsRepo.findByCode(code);

    if (!coupon) {
      throw AppException.notFound('Invalid coupon code');
    }

    if (!coupon.isActive) {
      throw new AppException('BAD_REQUEST', 'Coupon is not active', 400);
    }

    const now = new Date();
    if (now < coupon.validFrom || now > coupon.validTo) {
      throw new AppException('BAD_REQUEST', 'Coupon is expired or not yet valid', 400);
    }

    if (coupon.maxUses && coupon.currentUses >= coupon.maxUses) {
      throw AppException.couponMaxUsesReached();
    }

    if (coupon.minBookingAmount && bookingAmount < coupon.minBookingAmount) {
      throw new AppException(
        'BAD_REQUEST',
        `Minimum booking amount of ${coupon.minBookingAmount} required`,
        400,
      );
    }

    let discountAmount = 0;
    if (coupon.discountType === DiscountType.FLAT) {
      discountAmount = coupon.discountValue;
    } else {
      discountAmount = (bookingAmount * coupon.discountValue) / 100;
      if (coupon.maxDiscount && discountAmount > coupon.maxDiscount) {
        discountAmount = coupon.maxDiscount;
      }
    }

    if (discountAmount > bookingAmount) {
      discountAmount = bookingAmount;
    }

    return { coupon, discountAmount };
  }

  async redeemCoupon(couponId: string, customerId: string, bookingId: string, discount: number) {
    const coupon = await this.couponsRepo.findById(couponId);
    if (!coupon) {
      throw AppException.notFound('Coupon not found');
    }

    await this.couponsRepo.incrementUses(couponId);

    return this.couponsRepo.recordRedemption({
      couponId,
      customerId,
      bookingId,
      discountAmount: discount,
    });
  }

  async getCoupons(query: PaginationDto) {
    const skip = (query.page - 1) * query.limit;
    const [items, total] = await Promise.all([
      this.couponsRepo.findAll(skip, query.limit),
      this.couponsRepo.count(),
    ]);

    return {
      items,
      meta: {
        total,
        page: query.page,
        limit: query.limit,
        totalPages: Math.ceil(total / query.limit),
      },
    };
  }

  async getActiveCoupons() {
    return this.couponsRepo.findActive();
  }

  async updateCoupon(id: string, dto: UpdateCouponDto) {
    const coupon = await this.couponsRepo.findById(id);
    if (!coupon) {
      throw AppException.notFound('Coupon not found');
    }
    return this.couponsRepo.update(id, dto);
  }

  async deactivateCoupon(id: string) {
    const coupon = await this.couponsRepo.findById(id);
    if (!coupon) {
      throw AppException.notFound('Coupon not found');
    }
    return this.couponsRepo.deactivate(id);
  }
}
