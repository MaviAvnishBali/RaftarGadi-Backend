import { IsEnum, IsNumber, IsOptional, IsString, IsDateString, IsInt, Min } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum DiscountType {
  PERCENTAGE = 'PERCENTAGE',
  FLAT = 'FLAT',
}

export class CreateCouponDto {
  @ApiProperty({ example: 'SUMMER20' })
  @IsString()
  code!: string;

  @ApiPropertyOptional({ example: 'Summer discount' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ enum: DiscountType, example: DiscountType.PERCENTAGE })
  @IsEnum(DiscountType)
  discountType!: DiscountType;

  @ApiProperty({ example: 20 })
  @IsNumber()
  @Min(0)
  discountValue!: number;

  @ApiPropertyOptional({ example: 100 })
  @IsOptional()
  @IsNumber()
  maxDiscount?: number;

  @ApiPropertyOptional({ example: 50 })
  @IsOptional()
  @IsNumber()
  minBookingAmount?: number;

  @ApiPropertyOptional({ example: 100 })
  @IsOptional()
  @IsInt()
  maxUses?: number;

  @ApiProperty({ example: '2023-01-01T00:00:00Z' })
  @IsDateString()
  validFrom!: Date;

  @ApiProperty({ example: '2023-12-31T23:59:59Z' })
  @IsDateString()
  validTo!: Date;
}
