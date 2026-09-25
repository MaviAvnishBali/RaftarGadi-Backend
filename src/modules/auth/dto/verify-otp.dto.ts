import { IsString, IsNotEmpty, IsOptional, Length, IsEnum } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Role } from '@common/enums';

export class VerifyOtpDto {
  @ApiProperty({ description: 'The phone number the OTP was sent to' })
  @IsNotEmpty()
  @IsString()
  phone!: string;

  @ApiProperty({ description: 'The 6-digit OTP' })
  @IsNotEmpty()
  @IsString()
  @Length(6, 6)
  otp!: string;

  @ApiPropertyOptional({ enum: Role, default: Role.CUSTOMER })
  @IsOptional()
  @IsEnum(Role)
  role?: Role = Role.CUSTOMER;

  @ApiPropertyOptional({ description: 'Device information' })
  @IsOptional()
  @IsString()
  deviceInfo?: string;
}
