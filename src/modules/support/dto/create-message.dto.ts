import { IsNotEmpty, IsString, MaxLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateMessageDto {
  @ApiProperty({ example: 'Hello, I need help with my delivery.' })
  @IsString()
  @IsNotEmpty()
  @MaxLength(3000)
  message!: string;
}
