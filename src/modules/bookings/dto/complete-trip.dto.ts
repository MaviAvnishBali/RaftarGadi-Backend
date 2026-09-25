import { IsNumber, Min } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

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
