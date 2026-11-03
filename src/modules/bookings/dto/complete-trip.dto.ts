import { IsNumber, Min, IsOptional, IsString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CompleteTripDto {
  @ApiProperty({ description: 'Actual distance covered in km' })
  @IsNumber()
  @Min(0)
  actualDistanceKm!: number;

  @ApiProperty({ description: 'Actual duration taken in minutes' })
  @IsNumber()
  @Min(0)
  actualDurationMin!: number;
}

export class StartTripDto {
  @ApiPropertyOptional({ description: 'Customer pickup verification OTP' })
  @IsOptional()
  @IsString()
  otp?: string;
}

