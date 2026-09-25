import { IsString, IsNumber, Min } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class ValidateCouponDto {
  @ApiProperty({ example: 'SUMMER20' })
  @IsString()
  code!: string;

  @ApiProperty({ example: 100 })
  @IsNumber()
  @Min(0)
  bookingAmount!: number;
}
