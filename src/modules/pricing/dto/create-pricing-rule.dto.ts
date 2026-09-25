import { IsString, IsNumber, IsOptional, Min, IsUUID, IsDateString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreatePricingRuleDto {
  @ApiProperty()
  @IsUUID()
  vehicleTypeId!: string;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  city?: string;

  @ApiProperty()
  @IsNumber()
  @Min(0)
  baseFare!: number;

  @ApiProperty()
  @IsNumber()
  @Min(0)
  perKmCharge!: number;

  @ApiProperty()
  @IsNumber()
  @Min(0)
  perMinCharge!: number;

  @ApiProperty()
  @IsNumber()
  @Min(0)
  minimumFare!: number;

  @ApiProperty()
  @IsNumber()
  @Min(0)
  platformFeePercent!: number;

  @ApiProperty()
  @IsNumber()
  @Min(0)
  taxPercent!: number;

  @ApiPropertyOptional()
  @IsNumber()
  @Min(1)
  @IsOptional()
  surgeMultiplier?: number;

  @ApiProperty()
  @IsDateString()
  effectiveFrom!: Date;

  @ApiPropertyOptional()
  @IsDateString()
  @IsOptional()
  effectiveTo?: Date;
}
