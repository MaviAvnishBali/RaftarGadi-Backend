import { IsOptional, IsUUID, IsEnum, IsString } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';
import { BookingQueryDto } from './booking-query.dto';
import { PaymentStatus } from '../enums/booking-status.enum';

export class AdminBookingQueryDto extends BookingQueryDto {
  @ApiPropertyOptional({ description: 'Customer ID' })
  @IsOptional()
  @IsUUID()
  customerId?: string;

  @ApiPropertyOptional({ description: 'Driver ID' })
  @IsOptional()
  @IsUUID()
  driverId?: string;

  @ApiPropertyOptional({ enum: PaymentStatus })
  @IsOptional()
  @IsEnum(PaymentStatus)
  paymentStatus?: PaymentStatus;

  @ApiPropertyOptional({ description: 'Search term (booking number, etc.)' })
  @IsOptional()
  @IsString()
  search?: string;
}
