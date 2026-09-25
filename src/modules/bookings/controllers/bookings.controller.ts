import { Controller, Post, Get, Body, Param, Query, Headers, UseGuards } from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { BookingsService } from '../services/bookings.service';
import { CreateBookingDto } from '../dto/create-booking.dto';
import { BookingQueryDto } from '../dto/booking-query.dto';
import { AdminBookingQueryDto } from '../dto/admin-booking-query.dto';
import { CancelBookingDto } from '../dto/cancel-booking.dto';
import { CompleteTripDto } from '../dto/complete-trip.dto';
import { Role, Permission } from '../../../common/enums';
import { Roles, Permissions, CurrentUser, JwtPayload } from '../../../common/decorators';

@ApiTags('Bookings')
@ApiBearerAuth('access-token')
@Controller({ path: 'bookings', version: '1' })
export class BookingsController {
  constructor(private readonly bookingsService: BookingsService) {}

  @Post()
  @Roles(Role.CUSTOMER)
  @Permissions(Permission.BOOKING_CREATE)
  async createBooking(
    @CurrentUser() user: JwtPayload,
    @Body() dto: CreateBookingDto,
    @Headers('idempotency-key') idempotencyKey?: string,
  ) {
    return this.bookingsService.createBooking(user.sub, dto, idempotencyKey);
  }

  @Get()
  @Roles(Role.CUSTOMER)
  async getCustomerBookings(@CurrentUser() user: JwtPayload, @Query() query: BookingQueryDto) {
    return this.bookingsService.getCustomerBookings(user.sub, query);
  }

  @Get('driver')
  @Roles(Role.DRIVER)
  async getDriverBookings(@CurrentUser() user: JwtPayload, @Query() query: BookingQueryDto) {
    return this.bookingsService.getDriverBookings(user.sub, query);
  }

  @Get('all')
  @Roles(Role.ADMIN)
  async getAllBookings(@Query() query: AdminBookingQueryDto) {
    return this.bookingsService.getAllBookings(query);
  }

  @Get('stats')
  @Roles(Role.ADMIN)
  async getBookingStats() {
    return this.bookingsService.getBookingStats();
  }

  @Get(':id')
  async getBookingById(@Param('id') id: string) {
    return this.bookingsService.findById(id);
  }

  @Post(':id/cancel')
  async cancelBooking(
    @Param('id') id: string,
    @CurrentUser() user: JwtPayload,
    @Body() dto: CancelBookingDto,
  ) {
    return this.bookingsService.cancelBooking(id, user.sub, user.role, dto.reason);
  }

  @Post(':id/accept')
  @Roles(Role.DRIVER)
  async acceptBooking(@Param('id') id: string, @CurrentUser() user: JwtPayload) {
    return this.bookingsService.transitionStatus(
      id,
      'DRIVER_ARRIVING',
      user.sub,
      'Driver accepted booking',
    );
  }

  @Post(':id/arrived')
  @Roles(Role.DRIVER)
  async driverArrived(@Param('id') id: string, @CurrentUser() user: JwtPayload) {
    return this.bookingsService.transitionStatus(
      id,
      'DRIVER_ARRIVED',
      user.sub,
      'Driver arrived at pickup',
    );
  }

  @Post(':id/start')
  @Roles(Role.DRIVER)
  async startTrip(@Param('id') id: string, @CurrentUser() user: JwtPayload) {
    return this.bookingsService.startTrip(id, user.sub);
  }

  @Post(':id/complete')
  @Roles(Role.DRIVER)
  async completeTrip(
    @Param('id') id: string,
    @CurrentUser() user: JwtPayload,
    @Body() dto: CompleteTripDto,
  ) {
    return this.bookingsService.completeTrip(
      id,
      user.sub,
      dto.actualDistanceKm,
      dto.actualDurationMin,
    );
  }
}
