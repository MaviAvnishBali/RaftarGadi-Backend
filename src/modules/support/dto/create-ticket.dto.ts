import { IsEnum, IsOptional, IsString, IsUUID, MaxLength } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum TicketPriority {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  URGENT = 'URGENT',
}

export class CreateTicketDto {
  @ApiPropertyOptional({ example: '123e4567-e89b-12d3-a456-426614174000' })
  @IsOptional()
  @IsUUID()
  bookingId?: string;

  @ApiProperty({ example: 'Issue with recent ride' })
  @IsString()
  subject!: string;

  @ApiProperty({ example: 'The driver was very late.' })
  @IsString()
  @MaxLength(2000)
  description!: string;

  @ApiPropertyOptional({ enum: TicketPriority, example: TicketPriority.MEDIUM })
  @IsOptional()
  @IsEnum(TicketPriority)
  priority?: TicketPriority;
}
