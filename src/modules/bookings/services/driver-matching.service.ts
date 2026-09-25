import { Injectable, Logger } from '@nestjs/common';
import { BookingsRepository } from '../repositories/bookings.repository';
import { RedisService } from '../../../config/redis.service';
import { PrismaService } from '../../../database/prisma.service';

@Injectable()
export class DriverMatchingService {
  private readonly logger = new Logger(DriverMatchingService.name);

  constructor(
    private readonly bookingsRepo: BookingsRepository,
    private readonly redisService: RedisService,
    private readonly prisma: PrismaService,
  ) {}

  async findAndAssignDriver(bookingId: string): Promise<void> {
    try {
      const booking = await this.bookingsRepo.findById(bookingId);
      if (!booking || booking.status !== 'REQUESTED') {
        return;
      }

      // Update to SEARCHING_DRIVER
      await this.prisma.booking.update({
        where: { id: bookingId },
        data: {
          status: 'SEARCHING_DRIVER',
          statusHistory: {
            create: {
              oldStatus: booking.status,
              newStatus: 'SEARCHING_DRIVER',
              changedBy: 'SYSTEM',
              reason: 'Started driver search',
            },
          },
        },
      });

      // Dummy implementation for now - real matching comes in Locations module
      this.logger.log(
        `Searching for driver for booking ${bookingId} at [${booking.pickupLat}, ${booking.pickupLng}]`,
      );

      // 1. Get drivers in 5km radius (pseudo logic)
      // 2. Filter by vehicleTypeId, ONLINE status, isAvailable=true
      // 3. Rank by distance and rating
      // 4. Assign best match

      // Since actual Redis geo/driver location management is in Locations module,
      // we'll just log and leave in SEARCHING_DRIVER state for now until auto-assign is built.
      this.logger.warn(
        `Driver matching logic pending real-time Location Module integration. Booking ${bookingId} stays in SEARCHING_DRIVER.`,
      );
    } catch (error) {
      this.logger.error(`Error finding driver for booking ${bookingId}`, error);
    }
  }
}
