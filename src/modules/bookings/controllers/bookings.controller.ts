import { Controller, Post, Get, Body, Param, Query, Headers, UseGuards } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { BookingsService } from '../services/bookings.service';
import { CreateBookingDto } from '../dto/create-booking.dto';
import { BookingQueryDto } from '../dto/booking-query.dto';
import { AdminBookingQueryDto } from '../dto/admin-booking-query.dto';
import { CancelBookingDto } from '../dto/cancel-booking.dto';
import { CompleteTripDto, StartTripDto } from '../dto/complete-trip.dto';
import { Role, Permission } from '../../../common/enums';
import { Roles, Permissions, CurrentUser, JwtPayload } from '../../../common/decorators';

@ApiTags('Bookings')
@ApiBearerAuth('access-token')
@Controller({ path: 'bookings', version: '1' })
export class BookingsController {
  constructor(private readonly bookingsService: BookingsService) {}

  @Post()
  @Roles(Role.CUSTOMER, Role.DRIVER, Role.ADMIN, Role.SUPER_ADMIN)
  @Permissions(Permission.BOOKING_CREATE)
  async createBooking(
    @CurrentUser() user: JwtPayload,
    @Body() dto: CreateBookingDto,
    @Headers('idempotency-key') idempotencyKey?: string,
  ) {
    return this.bookingsService.createBooking(user.sub, dto, idempotencyKey);
  }

  @Get()
  @Roles(Role.CUSTOMER, Role.DRIVER, Role.ADMIN, Role.SUPER_ADMIN)
  async getCustomerBookings(@CurrentUser() user: JwtPayload, @Query() query: BookingQueryDto) {
    return this.bookingsService.getCustomerBookings(user.sub, query);
  }

  @Get('driver')
  @Roles(Role.DRIVER)
  async getDriverBookings(@CurrentUser() user: JwtPayload, @Query() query: BookingQueryDto) {
    return this.bookingsService.getDriverBookings(user.sub, query);
  }

  @Get('all')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  async getAllBookings(@Query() query: AdminBookingQueryDto) {
    return this.bookingsService.getAllBookings(query);
  }

  @Get('stats')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
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

  @Post('simulate-order')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Simulate an incoming order for online driver' })
  async simulateOrder(@CurrentUser('sub') userId: string) {
    return this.bookingsService.simulateOrder(userId);
  }

  @Post(':id/accept')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Accept incoming order' })
  async acceptBooking(@Param('id') id: string, @CurrentUser('sub') userId: string) {
    return this.bookingsService.driverAcceptBooking(id, userId);
  }

  @Post(':id/arrived')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Driver arrived at pickup' })
  async driverArrived(@Param('id') id: string, @CurrentUser('sub') userId: string) {
    return this.bookingsService.driverArrived(id, userId);
  }

  @Post(':id/start')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Start delivery trip' })
  async startTrip(
    @Param('id') id: string,
    @CurrentUser('sub') userId: string,
    @Body() dto?: StartTripDto,
  ) {
    return this.bookingsService.startTrip(id, userId, dto?.otp);
  }

  @Post(':id/complete')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Complete delivery trip' })
  async completeTrip(
    @Param('id') id: string,
    @CurrentUser('sub') userId: string,
    @Body() dto?: CompleteTripDto,
  ) {
    return this.bookingsService.completeTrip(
      id,
      userId,
      dto?.actualDistanceKm,
      dto?.actualDurationMin,
    );
  }
}
