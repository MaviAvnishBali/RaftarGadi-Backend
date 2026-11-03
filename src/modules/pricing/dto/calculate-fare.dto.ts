import { IsString, IsNumber, IsOptional, Min, IsUUID } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CalculateFareDto {
  @ApiPropertyOptional({ description: 'Vehicle Type ID (UUID)' })
  @IsString()
  @IsOptional()
  vehicleTypeId?: string;

  @ApiPropertyOptional({ description: 'Vehicle Type name (e.g. bike, auto, miniTruck)' })
  @IsString()
  @IsOptional()
  vehicleType?: string;

  @ApiProperty({ description: 'Distance in kilometers', minimum: 0 })
  @IsNumber()
  @Min(0)
  distanceKm!: number;

  @ApiPropertyOptional({ description: 'Duration in minutes', minimum: 0 })
  @IsNumber()
  @Min(0)
  @IsOptional()
  durationMin?: number;

  @ApiPropertyOptional({ description: 'Duration in minutes (alias)' })
  @IsNumber()
  @Min(0)
  @IsOptional()
  durationMinutes?: number;

  @ApiPropertyOptional({ description: 'City name', default: 'default' })
  @IsString()
  @IsOptional()
  city?: string = 'default';

  @ApiPropertyOptional({ description: 'Optional coupon code' })
  @IsString()
  @IsOptional()
  couponCode?: string;
}
