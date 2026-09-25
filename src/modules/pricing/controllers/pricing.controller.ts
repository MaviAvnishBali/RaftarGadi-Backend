import {
  Controller,
  Post,
  Get,
  Patch,
  Body,
  Param,
  Query,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { PricingService } from '../services/pricing.service';
import { CalculateFareDto } from '../dto/calculate-fare.dto';
import { CreatePricingRuleDto } from '../dto/create-pricing-rule.dto';
import { UpdatePricingRuleDto } from '../dto/update-pricing-rule.dto';
import { PaginationDto } from '../../../common/dto/pagination.dto';
import { Public, Permissions } from '../../../common/decorators';
import { Permission } from '../../../common/enums';

@ApiTags('Pricing')
@ApiBearerAuth('access-token')
@Controller({ path: 'pricing', version: '1' })
export class PricingController {
  constructor(private readonly pricingService: PricingService) {}

  @Public()
  @Post('estimate')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Calculate fare estimate' })
  async estimateFare(@Body() dto: CalculateFareDto) {
    return this.pricingService.calculateEstimatedFare(dto);
  }

  @Permissions(Permission.PRICING_MANAGE)
  @Get('rules')
  @ApiOperation({ summary: 'List pricing rules' })
  async getRules(@Query() query: PaginationDto) {
    return this.pricingService.getPricingRules(query);
  }

  @Permissions(Permission.PRICING_MANAGE)
  @Post('rules')
  @ApiOperation({ summary: 'Create pricing rule' })
  async createRule(@Body() dto: CreatePricingRuleDto) {
    return this.pricingService.createPricingRule(dto);
  }

  @Permissions(Permission.PRICING_MANAGE)
  @Patch('rules/:id')
  @ApiOperation({ summary: 'Update pricing rule' })
  async updateRule(@Param('id') id: string, @Body() dto: UpdatePricingRuleDto) {
    return this.pricingService.updatePricingRule(id, dto);
  }

  @Permissions(Permission.PRICING_MANAGE)
  @Post('surge')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Set surge multiplier' })
  async setSurge(
    @Body('vehicleTypeId') vehicleTypeId: string,
    @Body('multiplier') multiplier: number,
  ) {
    await this.pricingService.setSurge(vehicleTypeId, multiplier);
    return { success: true };
  }
}
