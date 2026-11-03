import { IsNumber, IsString, IsOptional, IsUUID, Min, Max, IsDateString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { PaymentMethod } from '../enums/booking-status.enum';

export class CreateBookingDto {
  @ApiProperty({ description: 'Pickup latitude', minimum: -90, maximum: 90 })
  @IsNumber()
  @Min(-90)
  @Max(90)
  pickupLat!: number;

  @ApiProperty({ description: 'Pickup longitude', minimum: -180, maximum: 180 })
  @IsNumber()
  @Min(-180)
  @Max(180)
  pickupLng!: number;

  @ApiProperty({ description: 'Pickup address string' })
  @IsString()
  pickupAddress!: string;

  @ApiProperty({ description: 'Drop latitude', minimum: -90, maximum: 90 })
  @IsNumber()
  @Min(-90)
  @Max(90)
  dropLat!: number;

  @ApiProperty({ description: 'Drop longitude', minimum: -180, maximum: 180 })
  @IsNumber()
  @Min(-180)
  @Max(180)
  dropLng!: number;

  @ApiProperty({ description: 'Drop address string' })
  @IsString()
  dropAddress!: string;

  @ApiPropertyOptional({ description: 'Vehicle type ID' })
  @IsOptional()
  @IsString()
  vehicleTypeId?: string;

  @ApiPropertyOptional({ description: 'Vehicle type name (e.g. bike, auto, miniTruck)' })
  @IsOptional()
  @IsString()
  vehicleType?: string;

  @ApiPropertyOptional({ description: 'Customer ID override' })
  @IsOptional()
  @IsString()
  customerId?: string;

  @ApiPropertyOptional({ description: 'Estimated fare' })
  @IsOptional()
  @IsNumber()
  estimatedFare?: number;

  @ApiPropertyOptional({ description: 'Estimated distance in km' })
  @IsOptional()
  @IsNumber()
  estimatedDistanceKm?: number;

  @ApiPropertyOptional({ description: 'Estimated duration in minutes' })
  @IsOptional()
  @IsNumber()
  estimatedDurationMin?: number;

  @ApiPropertyOptional({ description: 'Delivery note' })
  @IsOptional()
  @IsString()
  note?: string;

  @ApiPropertyOptional({ description: 'Package type' })
  @IsOptional()
  @IsString()
  packageType?: string;

  @ApiPropertyOptional({ description: 'Package description' })
  @IsOptional()
  @IsString()
  packageDescription?: string;

  @ApiPropertyOptional({ description: 'Package weight in kg', minimum: 0 })
  @IsOptional()
  @IsNumber()
  @Min(0)
  packageWeightKg?: number;

  @ApiPropertyOptional({ description: 'Payment method', enum: PaymentMethod })
  @IsOptional()
  paymentMethod?: PaymentMethod;

  @ApiPropertyOptional({ description: 'Coupon code' })
  @IsOptional()
  @IsString()
  couponCode?: string;

  @ApiPropertyOptional({ description: 'Scheduled date and time' })
  @IsOptional()
  @IsDateString()
  scheduledAt?: Date;

  @ApiPropertyOptional({ description: 'Pickup object metadata' })
  @IsOptional()
  pickup?: any;

  @ApiPropertyOptional({ description: 'Drop object metadata' })
  @IsOptional()
  drop?: any;

  @ApiPropertyOptional({ description: 'Fare object metadata' })
  @IsOptional()
  fare?: any;
}
