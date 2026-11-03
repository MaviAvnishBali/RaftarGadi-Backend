import { PartialType, ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString, IsNumber, Min } from 'class-validator';
import { CreatePricingRuleDto } from './create-pricing-rule.dto';

export class UpdatePricingRuleDto extends PartialType(CreatePricingRuleDto) {
  @ApiPropertyOptional({ description: 'Vehicle cargo bed dimensions (e.g. 7ft x 4.8ft x 4.8ft)' })
  @IsString()
  @IsOptional()
  dimensions?: string;

  @ApiPropertyOptional({ description: 'Max vehicle payload capacity in kg' })
  @IsNumber()
  @Min(0)
  @IsOptional()
  maxWeightKg?: number;
}

