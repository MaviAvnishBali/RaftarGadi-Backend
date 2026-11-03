import {
  Injectable,
  Logger,
  OnApplicationBootstrap,
  OnApplicationShutdown,
} from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';
import { RedisService } from '../../../config/redis.service';

@Injectable()
export class DriverLivenessService
  implements OnApplicationBootstrap, OnApplicationShutdown
{
  private readonly logger = new Logger(DriverLivenessService.name);
  private intervalTimer?: NodeJS.Timeout;
  private readonly STALE_THRESHOLD_MS = 90 * 1000; // 90 seconds
  private readonly SWEEP_INTERVAL_MS = 30 * 1000; // Run every 30 seconds

  constructor(
    private readonly prisma: PrismaService,
    private readonly redisService: RedisService,
  ) {}

  onApplicationBootstrap() {
    this.logger.log(
      'Starting DriverLivenessService background sweeper (interval: 30s, stale threshold: 90s)',
    );
    this.intervalTimer = setInterval(() => {
      this.sweepInactiveDrivers().catch((err) => {
        this.logger.error(
          `Error during driver liveness sweep: ${err.message}`,
          err.stack,
        );
      });
    }, this.SWEEP_INTERVAL_MS);
  }

  onApplicationShutdown() {
    if (this.intervalTimer) {
      clearInterval(this.intervalTimer);
      this.intervalTimer = undefined;
    }
  }

  async sweepInactiveDrivers(): Promise<void> {
    try {
      // Find all drivers currently marked ONLINE in PostgreSQL
      const onlineDrivers = await this.prisma.driver.findMany({
        where: { status: 'ONLINE' },
        select: {
          id: true,
          userId: true,
          updatedAt: true,
          bookings: {
            where: {
              status: {
                in: [
                  'DRIVER_ASSIGNED',
                  'DRIVER_ARRIVING',
                  'DRIVER_ARRIVED',
                  'TRIP_STARTED',
                ],
              },
            },
            select: { id: true },
          },
        },
      });

      if (!onlineDrivers.length) return;

      const client = this.redisService.client;
      const now = Date.now();

      for (const driver of onlineDrivers) {
        // If driver has an ongoing trip, do not force them offline
        if (driver.bookings.length > 0) continue;

        const locData = await client.get(`driver:location:${driver.id}`);
        let isStale = false;

        if (!locData) {
          // No location in Redis at all -> driver app uninstalled or killed
          isStale = true;
        } else {
          try {
            const parsed = JSON.parse(locData);
            const lastUpdated = parsed.timestamp || 0;
            if (now - lastUpdated > this.STALE_THRESHOLD_MS) {
              isStale = true;
            }
          } catch (_) {
            isStale = true;
          }
        }

        if (isStale) {
          this.logger.warn(
            `Driver ${driver.id} (user: ${driver.userId}) has missed heartbeats (>90s). Setting status to OFFLINE.`,
          );

          // Update PostgreSQL
          await this.prisma.driver.update({
            where: { id: driver.id },
            data: { status: 'OFFLINE', isAvailable: false },
          });

          // Clean Redis
          await client.zrem('drivers:online', driver.id);
          await client.del(`driver:location:${driver.id}`);
          await client.del(`ws:client:${driver.userId}`);
        }
      }
    } catch (err) {
      this.logger.error(`Failed to sweep inactive drivers: ${err}`);
    }
  }
}
