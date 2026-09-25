import { Injectable } from '@nestjs/common';
import { RedisService } from '../../../config/redis.service';
import { PrismaService } from '../../../database/prisma.service';
import { NearbyDriver } from '../interfaces/location.interfaces';

@Injectable()
export class LocationsService {
  constructor(
    private readonly redisService: RedisService,
    private readonly prisma: PrismaService,
  ) {}

  async updateDriverLocation(driverId: string, lat: number, lng: number): Promise<void> {
    const client = this.redisService.client;
    await client.geoadd('drivers:online', lng, lat, driverId);
    await client.set(
      `driver:location:${driverId}`,
      JSON.stringify({ lat, lng, timestamp: Date.now() }),
    );
  }

  async removeDriverLocation(driverId: string): Promise<void> {
    const client = this.redisService.client;
    await client.zrem('drivers:online', driverId);
    await client.del(`driver:location:${driverId}`);
  }

  async getDriverLocation(
    driverId: string,
  ): Promise<{ latitude: number; longitude: number } | null> {
    const client = this.redisService.client;
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
    const client = this.redisService.client;
    const results = (await client.georadius(
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

    return results.map((result) => ({
      driverId: result[0],
      distanceKm: Number(result[1]),
    }));
  }

  async saveBookingLocation(
    bookingId: string,
    lat: number,
    lng: number,
    heading?: number,
    speed?: number,
  ): Promise<void> {
    await this.prisma.bookingLocation.create({
      data: {
        bookingId,
        latitude: lat,
        longitude: lng,
        heading,
        speed,
        recordedAt: new Date(),
      },
    });
  }
}
