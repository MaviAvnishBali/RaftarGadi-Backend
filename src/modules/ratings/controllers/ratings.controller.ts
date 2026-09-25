import { Controller, Post, Get, Body, Param, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { RatingsService } from '../services/ratings.service';
import { CreateRatingDto } from '../dto/create-rating.dto';
import { PaginationDto } from '../../../common/dto/pagination.dto';
import { CurrentUser, Roles } from '../../../common/decorators';
import { Role } from '../../../common/enums';

@ApiTags('Ratings')
@ApiBearerAuth('access-token')
@Controller({ version: '1', path: 'ratings' })
export class RatingsController {
  constructor(private readonly ratingsService: RatingsService) {}

  @Post()
  @Roles(Role.CUSTOMER)
  @ApiOperation({ summary: 'Create a rating for a booking' })
  async createRating(@CurrentUser() user: any, @Body() dto: CreateRatingDto) {
    return this.ratingsService.createRating(user.sub, dto);
  }

  @Get('booking/:bookingId')
  @ApiOperation({ summary: 'Get rating for a specific booking' })
  async getBookingRating(@Param('bookingId') bookingId: string) {
    return this.ratingsService.getBookingRating(bookingId);
  }

  @Get('driver/:driverId')
  @ApiOperation({ summary: 'Get ratings for a driver' })
  async getDriverRatings(@Param('driverId') driverId: string, @Query() query: PaginationDto) {
    return this.ratingsService.getDriverRatings(driverId, query);
  }
}
