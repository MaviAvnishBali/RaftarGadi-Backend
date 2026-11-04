import { Injectable } from '@nestjs/common';
import { RedisService } from '../../../config/redis.service';
import { PrismaService } from '../../../database/prisma.service';
import { NearbyDriver } from '../interfaces/location.interfaces';
import { AppException } from '../../../common/exceptions/app.exception';

@Injectable()
export class LocationsService {
  constructor(
    private readonly redisService: RedisService,
    private readonly prisma: PrismaService,
  ) {}

  async updateDriverLocation(
    driverId: string,
    lat: number,
    lng: number,
    heading?: number,
    speed?: number,
  ): Promise<void> {
    if (isNaN(lat) || isNaN(lng) || lat < -90 || lat > 90 || lng < -180 || lng > 180) {
      throw new AppException('BAD_REQUEST', `Invalid coordinates: lat=${lat}, lng=${lng}`, 400);
    }

    const client = this.redisService.client;
    await client.geoadd('drivers:online', lng, lat, driverId);
    await client.set(
      `driver:location:${driverId}`,
      JSON.stringify({
        lat,
        lng,
        heading: heading ?? 0,
        speed: speed ?? 0,
        timestamp: Date.now(),
      }),
      'EX',
      86400, // 24hr TTL
    );
  }

  async removeDriverLocation(driverId: string): Promise<void> {
    const client = this.redisService.client;
    await client.zrem('drivers:online', driverId);
    await client.del(`driver:location:${driverId}`);
  }

  async getDriverLocation(
    driverId: string,
  ): Promise<{ latitude: number; longitude: number; heading?: number; speed?: number; updatedAt?: Date } | null> {
    const client = this.redisService.client;
    const raw = await client.get(`driver:location:${driverId}`);
    if (raw) {
      try {
        const parsed = JSON.parse(raw);
        return {
          latitude: Number(parsed.lat),
          longitude: Number(parsed.lng),
          heading: parsed.heading ?? 0,
          speed: parsed.speed ?? 0,
          updatedAt: parsed.timestamp ? new Date(parsed.timestamp) : new Date(),
        };
      } catch (_) {}
    }

    const pos = await client.geopos('drivers:online', driverId);
    if (!pos || !pos[0]) {
      return null;
    }
    return {
      longitude: Number(pos[0][0]),
      latitude: Number(pos[0][1]),
    };
  }

  async findNearbyDrivers(
    lat: number,
    lng: number,
    radiusKm: number,
    maxResults: number,
  ): Promise<NearbyDriver[]> {
    if (isNaN(lat) || isNaN(lng) || lat < -90 || lat > 90 || lng < -180 || lng > 180) {
      return [];
    }

    const client = this.redisService.client;
    let rawResults: any[] = [];

    // Attempt GEOSEARCH first (Redis 6.2+)
    try {
      rawResults = (await (client as any).geosearch(
        'drivers:online',
        'FROMLONLAT',
        lng,
        lat,
        'BYRADIUS',
        radiusKm,
        'km',
        'ASC',
        'WITHDIST',
        'COUNT',
        maxResults,
      )) as any[];
    } catch (_) {
      // Fallback to legacy GEORADIUS if GEOSEARCH is unavailable
      try {
        rawResults = (await client.georadius(
          'drivers:online',
          lng,
          lat,
          radiusKm,
          'km',
          'WITHDIST',
          'ASC',
          'COUNT',
          maxResults,
        )) as any[];
      } catch (err) {
        return [];
      }
    }

    if (!Array.isArray(rawResults)) {
      return [];
    }

    // Filter out stale locations (> 90 seconds old: uninstalled app, killed process, or network lost)
    const now = Date.now();
    const staleThresholdMs = 90 * 1000; // 90 seconds
    const nearby: NearbyDriver[] = [];

    for (const item of rawResults) {
      const driverId = Array.isArray(item) ? item[0] : item;
      const dist = Array.isArray(item) && item[1] ? Number(item[1]) : 0;

      if (!driverId) continue;

      // Check staleness from driver:location cache
      const locData = await client.get(`driver:location:${driverId}`);
      if (!locData) {
        // No location cache exists: remove from online geo set and exclude
        await client.zrem('drivers:online', driverId);
        continue;
      }

      try {
        const parsed = JSON.parse(locData);
        if (!parsed.timestamp || now - parsed.timestamp > staleThresholdMs) {
          // Location is older than 90s: driver is inactive/uninstalled/offline
          await client.zrem('drivers:online', driverId);
          await client.del(`driver:location:${driverId}`);
          continue;
        }
      } catch (_) {
        await client.zrem('drivers:online', driverId);
        continue;
      }

      nearby.push({
        driverId: String(driverId),
        distanceKm: dist,
      });
    }

    return nearby;
  }

  async saveBookingLocation(
    bookingId: string,
    lat: number,
    lng: number,
    heading?: number,
    speed?: number,
  ): Promise<void> {
    const client = this.redisService.client;
    const now = Date.now();

    // 1. Instantly buffer in Redis for zero-latency tracking
    try {
      await client.set(
        `booking:${bookingId}:live_location`,
        JSON.stringify({ lat, lng, heading: heading ?? 0, speed: speed ?? 0, timestamp: now }),
        'EX',
        86400,
      );

      // Append to telemetry stream
      await client.xadd(
        'stream:telemetry',
        '*',
        'bookingId',
        bookingId,
        'lat',
        lat.toString(),
        'lng',
        lng.toString(),
        'heading',
        (heading ?? 0).toString(),
        'speed',
        (speed ?? 0).toString(),
        'recordedAt',
        now.toString(),
      );
    } catch (_) {
      // Non-blocking Redis fallback
    }

    // 2. Downsampled persistence to PostgreSQL (max 1 write per 15s to prevent pool exhaustion)
    let shouldSaveToPg = true;
    try {
      const throttleKey = `booking:${bookingId}:last_pg_save`;
      const throttled = await client.get(throttleKey);
      if (throttled) {
        shouldSaveToPg = false;
      } else {
        await client.set(throttleKey, '1', 'EX', 15);
      }
    } catch (_) {}

    if (shouldSaveToPg) {
      await this.prisma.bookingLocation.create({
        data: {
          bookingId,
          latitude: lat,
          longitude: lng,
          heading: heading ?? 0,
          speed: speed ?? 0,
          recordedAt: new Date(),
        },
      });
    }
  }

  async getBookingLiveTracking(bookingId: string) {
    const booking = await this.prisma.booking.findUnique({
      where: { id: bookingId },
      include: {
        driver: {
          include: {
            user: true,
            vehicle: { include: { vehicleType: true } },
          },
        },
        customer: { include: { user: true } },
      },
    });

    if (!booking) {
      throw new AppException('NOT_FOUND', 'Booking not found', 404);
    }

    let liveLocation: { latitude: number; longitude: number; heading?: number; speed?: number; updatedAt: Date } | null = null;

    if (booking.driverId) {
      const redisLoc = await this.getDriverLocation(booking.driverId);
      if (redisLoc) {
        liveLocation = {
          latitude: redisLoc.latitude,
          longitude: redisLoc.longitude,
          heading: redisLoc.heading ?? 0,
          speed: redisLoc.speed ?? 0,
          updatedAt: redisLoc.updatedAt ?? new Date(),
        };
      } else {
        const lastDbLoc = await this.prisma.bookingLocation.findFirst({
          where: { bookingId },
          orderBy: { recordedAt: 'desc' },
        });
        if (lastDbLoc) {
          liveLocation = {
            latitude: lastDbLoc.latitude,
            longitude: lastDbLoc.longitude,
            heading: lastDbLoc.heading ?? 0,
            speed: lastDbLoc.speed ?? 0,
            updatedAt: lastDbLoc.recordedAt,
          };
        }
      }
    }

    // Default to pickup coordinates if driver is assigned but no movement tracked yet
    if (!liveLocation && booking.driverId) {
      liveLocation = {
        latitude: booking.pickupLat,
        longitude: booking.pickupLng,
        heading: 0,
        speed: 0,
        updatedAt: new Date(),
      };
    }

    return {
      bookingId: booking.id,
      bookingNumber: booking.bookingNumber,
      status: booking.status,
      pickup: {
        address: booking.pickupAddress,
        lat: booking.pickupLat,
        lng: booking.pickupLng,
      },
      drop: {
        address: booking.dropAddress,
        lat: booking.dropLat,
        lng: booking.dropLng,
      },
      packageDescription: booking.packageDescription,
      packageType: booking.packageType,
      packageWeightKg: booking.packageWeightKg,
      estimatedFare: booking.estimatedFare,
      finalFare: booking.finalFare,
      driver: booking.driver
        ? {
            id: booking.driver.id,
            name: booking.driver.aadhaarName || booking.driver.user.name,
            phone: booking.driver.user.phone,
            rating: booking.driver.avgRating,
            vehicle: booking.driver.vehicle
              ? {
                  registrationNumber: booking.driver.vehicle.registrationNumber,
                  model: booking.driver.vehicle.model,
                  type: booking.driver.vehicle.vehicleType?.name,
                }
              : null,
          }
        : null,
      liveLocation,
      startOtp: await (async () => {
        try {
          return await this.redisService.client.get(`booking:${bookingId}:start_otp`);
        } catch (_) {
          return null;
        }
      })(),
    };
  }
}
