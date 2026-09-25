import { IsString, IsOptional } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';

export class UpdateDriverDto {
  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  licenseNumber?: string;
}
