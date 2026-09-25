import { IsString, IsNotEmpty } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class RegisterDriverDto {
  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  licenseNumber!: string;
}
