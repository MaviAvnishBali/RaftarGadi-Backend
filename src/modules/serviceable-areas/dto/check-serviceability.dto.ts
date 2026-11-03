import { IsNumber, Min, Max, IsOptional, IsString } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CheckServiceabilityDto {
  @ApiProperty({ description: 'Latitude coordinate to check', example: 28.6139 })
  @Type(() => Number)
  @IsNumber()
  @Min(-90)
  @Max(90)
  lat!: number;

  @ApiProperty({ description: 'Longitude coordinate to check', example: 77.2090 })
  @Type(() => Number)
  @IsNumber()
  @Min(-180)
  @Max(180)
  lng!: number;

  @ApiPropertyOptional({ description: 'Optional address text to check for localized operational rules' })
  @IsOptional()
  @IsString()
  address?: string;
}
