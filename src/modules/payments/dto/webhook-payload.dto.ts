import { IsString, IsNotEmpty } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class WebhookPayloadDto {
  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  orderId!: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  status!: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  transactionId!: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  signature!: string;
}
