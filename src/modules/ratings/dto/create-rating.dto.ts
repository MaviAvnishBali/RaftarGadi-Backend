import { IsInt, IsUUID, Max, MaxLength, Min, IsOptional, IsString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateRatingDto {
  @ApiProperty({ example: '123e4567-e89b-12d3-a456-426614174000', description: 'The booking ID' })
  @IsUUID()
  bookingId!: string;

  @ApiProperty({ example: 5, description: 'Rating from 1 to 5' })
  @IsInt()
  @Min(1)
  @Max(5)
  rating!: number;

  @ApiPropertyOptional({ example: 'Great service!', description: 'Optional review text' })
  @IsOptional()
  @IsString()
  @MaxLength(1000)
  review?: string;
}
