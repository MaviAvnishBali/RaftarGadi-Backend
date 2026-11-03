import { DriverStatus, KycStatus } from '@prisma/client';
import { IsOptional, IsEnum, IsString } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';
import { PaginationDto } from '../../../common/dto/pagination.dto';

export class DriverQueryDto extends PaginationDto {
  @ApiPropertyOptional({ description: 'Driver status (OFFLINE, ONLINE, BUSY, SUSPENDED, ACTIVE, PENDING_KYC, ALL)' })
  @IsString()
  @IsOptional()
  status?: string;

  @ApiPropertyOptional({ enum: KycStatus })
  @IsEnum(KycStatus)
  @IsOptional()
  kycStatus?: KycStatus;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  search?: string;
}
