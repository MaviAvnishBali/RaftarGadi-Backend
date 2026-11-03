import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString, Matches } from 'class-validator';

export class SubmitKycDto {
  @ApiProperty({
    description: 'Standard Indian Driving License Number (without spaces or dashes)',
    example: 'DL1420110012345',
  })
  @IsNotEmpty()
  @IsString()
  @Matches(/^[A-Z]{2}[0-9]{2}[0-9]{4}[0-9]{7}$/, {
    message: 'Invalid Driving License format. Expected 15-16 alphanumeric characters (e.g. DL1420110012345).',
  })
  licenseNumber!: string;

  @ApiProperty({
    description: 'Driver Date of Birth (YYYY-MM-DD)',
    example: '1995-05-20',
  })
  @IsNotEmpty()
  @IsString()
  @Matches(/^\d{4}-\d{2}-\d{2}$/, {
    message: 'Date of Birth must be in YYYY-MM-DD format.',
  })
  dob!: string;

  @ApiProperty({
    description: '12-digit Aadhaar Number',
    example: '548912345678',
  })
  @IsNotEmpty()
  @IsString()
  @Matches(/^[2-9]{1}[0-9]{11}$/, {
    message: 'Aadhaar Number must be a valid 12-digit Indian UIDAI number.',
  })
  aadhaarNumber!: string;

  @ApiProperty({
    description: 'Full Name as printed on Aadhaar Card',
    example: 'Ramesh Kumar',
  })
  @IsNotEmpty()
  @IsString()
  aadhaarName!: string;

  @ApiPropertyOptional({
    description: 'Optional Driving License Expiry Date (YYYY-MM-DD)',
    example: '2035-05-19',
  })
  @IsOptional()
  @IsString()
  licenseExpiry?: string;
}
