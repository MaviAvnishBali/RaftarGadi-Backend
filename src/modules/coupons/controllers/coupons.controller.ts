import { Controller, Post, Get, Body, Param, Query, Patch, Delete } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { CouponsService } from '../services/coupons.service';
import { CreateCouponDto } from '../dto/create-coupon.dto';
import { UpdateCouponDto } from '../dto/update-coupon.dto';
import { ValidateCouponDto } from '../dto/validate-coupon.dto';
import { PaginationDto } from '../../../common/dto/pagination.dto';
import { Roles, Permissions } from '../../../common/decorators';
import { Role, Permission } from '../../../common/enums';

@ApiTags('Coupons')
@ApiBearerAuth('access-token')
@Controller({ version: '1', path: 'coupons' })
export class CouponsController {
  constructor(private readonly couponsService: CouponsService) {}

  @Post('validate')
  @Roles(Role.CUSTOMER)
  @ApiOperation({ summary: 'Validate a coupon' })
  async validateCoupon(@Body() dto: ValidateCouponDto) {
    return this.couponsService.validateCoupon(dto.code, dto.bookingAmount);
  }

  @Get('active')
  @Roles(Role.CUSTOMER)
  @ApiOperation({ summary: 'List active coupons' })
  async getActiveCoupons() {
    return this.couponsService.getActiveCoupons();
  }

  @Get()
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @ApiOperation({ summary: 'List all coupons' })
  async getCoupons(@Query() query: PaginationDto) {
    return this.couponsService.getCoupons(query);
  }

  @Post()
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Permissions(Permission.COUPON_MANAGE)
  @ApiOperation({ summary: 'Create a new coupon' })
  async createCoupon(@Body() dto: CreateCouponDto) {
    return this.couponsService.createCoupon(dto);
  }

  @Patch(':id')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Permissions(Permission.COUPON_MANAGE)
  @ApiOperation({ summary: 'Update a coupon' })
  async updateCoupon(@Param('id') id: string, @Body() dto: UpdateCouponDto) {
    return this.couponsService.updateCoupon(id, dto);
  }

  @Delete(':id')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Permissions(Permission.COUPON_MANAGE)
  @ApiOperation({ summary: 'Deactivate a coupon' })
  async deactivateCoupon(@Param('id') id: string) {
    return this.couponsService.deactivateCoupon(id);
  }
}
