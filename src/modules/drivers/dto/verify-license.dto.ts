import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, Matches } from 'class-validator';

export class VerifyLicenseDto {
  @ApiProperty({
    description: 'The Driving License Number to verify',
    example: 'DL1420110012345',
  })
  @IsNotEmpty()
  @IsString()
  @Matches(/^[A-Z]{2}[0-9]{2}[0-9]{4}[0-9]{7}$/, {
    message: 'Invalid Driving License format',
  })
  licenseNumber!: string;
}
