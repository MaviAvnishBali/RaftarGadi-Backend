import { IsString, IsNotEmpty, IsOptional, IsNumber } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateVehicleTypeDto {
  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  name!: string;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  description?: string;

  @ApiPropertyOptional()
  @IsNumber()
  @IsOptional()
  maxWeightKg?: number;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  dimensions?: string;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  iconUrl?: string;

  @ApiPropertyOptional()
  @IsNumber()
  @IsOptional()
  sortOrder?: number;

  @ApiPropertyOptional({ description: 'Initial base fare in INR' })
  @IsNumber()
  @IsOptional()
  baseFare?: number;

  @ApiPropertyOptional({ description: 'Initial per km rate in INR' })
  @IsNumber()
  @IsOptional()
  perKmCharge?: number;

  @ApiPropertyOptional({ description: 'Initial per minute rate in INR' })
  @IsNumber()
  @IsOptional()
  perMinCharge?: number;

  @ApiPropertyOptional({ description: 'Initial minimum fare in INR' })
  @IsNumber()
  @IsOptional()
  minimumFare?: number;
}
