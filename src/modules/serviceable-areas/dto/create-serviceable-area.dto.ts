import { IsString, IsNotEmpty, IsNumber, Min, Max, IsBoolean, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateServiceableAreaDto {
  @ApiProperty({ description: 'City or area name', example: 'New Delhi' })
  @IsString()
  @IsNotEmpty()
  name!: string;

  @ApiProperty({ description: 'State or region name', example: 'Delhi NCR' })
  @IsString()
  @IsNotEmpty()
  state!: string;

  @ApiProperty({ description: 'Center point latitude', example: 28.6139, minimum: -90, maximum: 90 })
  @IsNumber()
  @Min(-90)
  @Max(90)
  centerLat!: number;

  @ApiProperty({ description: 'Center point longitude', example: 77.2090, minimum: -180, maximum: 180 })
  @IsNumber()
  @Min(-180)
  @Max(180)
  centerLng!: number;

  @ApiProperty({ description: 'Operational service radius around center in kilometers', example: 35.0, minimum: 1 })
  @IsNumber()
  @Min(0.5)
  radiusKm!: number;

  @ApiPropertyOptional({ description: 'Whether the area is currently active for accepting bookings', default: true })
  @IsBoolean()
  @IsOptional()
  isActive?: boolean;
}
