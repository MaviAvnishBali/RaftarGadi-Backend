import { IsOptional, IsEnum, IsDateString } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';

export enum ReportInterval {
  DAY = 'day',
  WEEK = 'week',
  MONTH = 'month',
}

export class ReportQueryDto {
  @ApiPropertyOptional({ example: '2023-01-01T00:00:00.000Z' })
  @IsOptional()
  @IsDateString()
  from?: string;

  @ApiPropertyOptional({ example: '2023-12-31T23:59:59.999Z' })
  @IsOptional()
  @IsDateString()
  to?: string;

  @ApiPropertyOptional({ enum: ReportInterval })
  @IsOptional()
  @IsEnum(ReportInterval)
  interval?: 'day' | 'week' | 'month';
}
