import { Controller, Post, Get, Body, Param, ParseUUIDPipe, HttpStatus } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { LocationsService } from '../services/locations.service';
import { LocationGateway } from '../gateways/location.gateway';
import { UpdateDriverLocationDto } from '../dto/update-driver-location.dto';
import { PrismaService } from '../../../database/prisma.service';
import { Role } from '../../../common/enums';
import { Roles, CurrentUser } from '../../../common/decorators';
import { AppException } from '../../../common/exceptions/app.exception';

@ApiTags('Locations')
@ApiBearerAuth('access-token')
@Controller({ path: 'locations', version: '1' })
export class LocationsController {
  constructor(
    private readonly locationsService: LocationsService,
    private readonly locationGateway: LocationGateway,
    private readonly prisma: PrismaService,
  ) {}

  @Post('driver')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Update driver live GPS coordinates' })
  async updateDriverLocation(
    @CurrentUser('sub') userId: string,
    @Body() dto: UpdateDriverLocationDto,
  ) {
    const driver = await this.prisma.driver.findUnique({
      where: { userId },
    });
    if (!driver) {
      throw new AppException('NOT_FOUND', 'Driver profile not found', 404);
    }

    await this.locationsService.updateDriverLocation(
      driver.id,
      dto.latitude,
      dto.longitude,
      dto.heading,
      dto.speed,
    );

    if (dto.bookingId) {
      await this.locationsService.saveBookingLocation(
        dto.bookingId,
        dto.latitude,
        dto.longitude,
        dto.heading,
        dto.speed,
      );

      this.locationGateway.sendToBookingRoom(dto.bookingId, 'driver:location', {
        driverId: driver.id,
        latitude: dto.latitude,
        longitude: dto.longitude,
        heading: dto.heading ?? 0,
        speed: dto.speed ?? 0,
        recordedAt: new Date().toISOString(),
      });
    }

    return { success: true };
  }

  @Get('booking/:bookingId')
  @ApiOperation({ summary: 'Get live tracking data for a booking' })
  async getBookingTracking(
    @Param('bookingId', ParseUUIDPipe) bookingId: string,
    @CurrentUser() user: any,
  ) {
    const booking = await this.prisma.booking.findUnique({
      where: { id: bookingId },
      include: {
        customer: true,
        driver: true,
      },
    });

    if (!booking) {
      throw new AppException('NOT_FOUND', 'Booking not found', 404);
    }

    const isAdmin = user.role === Role.ADMIN || user.role === Role.SUPER_ADMIN;
    const isCustomer = booking.customer?.userId === user.sub || booking.customerId === user.sub;
    const isAssignedDriver = booking.driver?.userId === user.sub || booking.driverId === user.sub;

    if (!isAdmin && !isCustomer && !isAssignedDriver) {
      throw new AppException(
        'AUTHZ_FORBIDDEN',
        'You are not authorized to view tracking data for this booking',
        HttpStatus.FORBIDDEN,
      );
    }

    const trackingData = await this.locationsService.getBookingLiveTracking(bookingId);

    // Hide customer's startOtp if requester is the assigned driver
    if (isAssignedDriver && !isAdmin && trackingData) {
      delete (trackingData as any).startOtp;
    }

    return trackingData;
  }

  @Get('driver/:driverId')
  @ApiOperation({ summary: 'Get current coordinates for a driver' })
  async getDriverLocation(
    @Param('driverId') driverId: string,
    @CurrentUser() user: any,
  ) {
    const isAdmin = user.role === Role.ADMIN || user.role === Role.SUPER_ADMIN;

    const driver = await this.prisma.driver.findFirst({
      where: { OR: [{ id: driverId }, { userId: driverId }] },
    });

    if (!driver) {
      throw new AppException('NOT_FOUND', 'Driver profile not found', 404);
    }

    const isDriverSelf = driver.userId === user.sub || driver.id === user.sub;

    if (!isAdmin && !isDriverSelf) {
      // Check if requester is a customer with an active trip assigned to this driver
      const activeBooking = await this.prisma.booking.findFirst({
        where: {
          driverId: driver.id,
          customer: { userId: user.sub },
          status: { in: ['DRIVER_ASSIGNED', 'DRIVER_ARRIVING', 'DRIVER_ARRIVED', 'TRIP_STARTED'] },
        },
      });

      if (!activeBooking) {
        throw new AppException(
          'AUTHZ_FORBIDDEN',
          'You do not have an active booking with this driver',
          HttpStatus.FORBIDDEN,
        );
      }
    }

    const location = await this.locationsService.getDriverLocation(driver.id);
    if (!location) {
      throw new AppException('NOT_FOUND', 'Driver location not available', 404);
    }
    return location;
  }
}
