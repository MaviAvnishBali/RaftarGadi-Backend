import { IsString, IsNotEmpty, IsUUID, IsOptional, IsNumber } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class RegisterVehicleDto {
  @ApiProperty()
  @IsUUID()
  @IsNotEmpty()
  vehicleTypeId!: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  registrationNumber!: string;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  model?: string;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  color?: string;

  @ApiPropertyOptional()
  @IsNumber()
  @IsOptional()
  manufactureYear?: number;
}
