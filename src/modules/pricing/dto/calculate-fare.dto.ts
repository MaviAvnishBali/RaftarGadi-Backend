import { IsString, IsNumber, IsOptional, Min, IsUUID } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CalculateFareDto {
  @ApiProperty({ description: 'Vehicle Type ID (UUID)' })
  @IsUUID()
  vehicleTypeId!: string;

  @ApiProperty({ description: 'Distance in kilometers', minimum: 0 })
  @IsNumber()
  @Min(0)
  distanceKm!: number;

  @ApiProperty({ description: 'Duration in minutes', minimum: 0 })
  @IsNumber()
  @Min(0)
  durationMin!: number;

  @ApiPropertyOptional({ description: 'City name', default: 'default' })
  @IsString()
  @IsOptional()
  city?: string = 'default';

  @ApiPropertyOptional({ description: 'Optional coupon code' })
  @IsString()
  @IsOptional()
  couponCode?: string;
}
