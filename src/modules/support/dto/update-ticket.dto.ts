import { IsEnum, IsOptional, IsUUID } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { TicketStatus } from './ticket-query.dto';

export class UpdateTicketDto {
  @ApiProperty({ enum: TicketStatus })
  @IsEnum(TicketStatus)
  status!: TicketStatus;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUUID()
  assignedTo?: string;
}
