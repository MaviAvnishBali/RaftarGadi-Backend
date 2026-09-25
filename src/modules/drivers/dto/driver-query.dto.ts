import { DriverStatus, KycStatus } from '@prisma/client';
import { IsOptional, IsEnum, IsString } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';
import { PaginationDto } from '../../../common/dto/pagination.dto';

export class DriverQueryDto extends PaginationDto {
  @ApiPropertyOptional({ enum: DriverStatus })
  @IsEnum(DriverStatus)
  @IsOptional()
  status?: DriverStatus;

  @ApiPropertyOptional({ enum: KycStatus })
  @IsEnum(KycStatus)
  @IsOptional()
  kycStatus?: KycStatus;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  search?: string;
}
