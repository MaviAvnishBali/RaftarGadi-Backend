import { Injectable, OnModuleDestroy, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import Redis from 'ioredis';

@Injectable()
export class RedisService implements OnModuleDestroy {
  private readonly logger = new Logger(RedisService.name);
  public readonly client: Redis;

  constructor(private readonly configService: ConfigService) {
    this.client = new Redis({
      host: this.configService.get<string>('REDIS_HOST', 'localhost'),
      port: this.configService.get<number>('REDIS_PORT', 6379),
      password: this.configService.get<string>('REDIS_PASSWORD') || undefined,
      db: this.configService.get<number>('REDIS_DB', 0),
      maxRetriesPerRequest: 3,
      retryStrategy: (times: number) => {
        if (times > 3) {
          this.logger.error('Redis connection failed after 3 retries');
          return null;
        }
        return Math.min(times * 200, 2000);
      },
    });

    this.client.on('connect', () => this.logger.log('Redis connected'));
    this.client.on('error', (err) => this.logger.error(`Redis error: ${err.message}`));
  }

  async onModuleDestroy(): Promise<void> {
    await this.client.quit();
  }

  // ─── Key-Value Operations ───────────────────────────
  async get(key: string): Promise<string | null> {
    return this.client.get(key);
  }

  async set(key: string, value: string, ttlSeconds?: number): Promise<void> {
    if (ttlSeconds) {
      await this.client.setex(key, ttlSeconds, value);
    } else {
      await this.client.set(key, value);
    }
  }

  async del(key: string): Promise<void> {
    await this.client.del(key);
  }

  async exists(key: string): Promise<boolean> {
    const result = await this.client.exists(key);
    return result === 1;
  }

  async incr(key: string): Promise<number> {
    return this.client.incr(key);
  }

  async expire(key: string, ttlSeconds: number): Promise<void> {
    await this.client.expire(key, ttlSeconds);
  }

  // ─── Hash Operations ────────────────────────────────
  async hset(key: string, field: string, value: string): Promise<void> {
    await this.client.hset(key, field, value);
  }

  async hget(key: string, field: string): Promise<string | null> {
    return this.client.hget(key, field);
  }

  async hgetall(key: string): Promise<Record<string, string>> {
    return this.client.hgetall(key);
  }

  async hdel(key: string, field: string): Promise<void> {
    await this.client.hdel(key, field);
  }

  // ─── Geo Operations (Driver Location) ───────────────
  async geoAdd(key: string, longitude: number, latitude: number, member: string): Promise<void> {
    await this.client.geoadd(key, longitude, latitude, member);
  }

  async geoRadius(
    key: string,
    longitude: number,
    latitude: number,
    radiusKm: number,
    count: number,
  ): Promise<Array<{ member: string; distance: number }>> {
    const results = await this.client.georadius(
      key,
      longitude,
      latitude,
      radiusKm,
      'km',
      'ASC',
      'COUNT',
      count,
      'WITHDIST',
    );

    return (results as Array<[string, string]>).map(([member, distance]) => ({
      member,
      distance: parseFloat(distance),
    }));
  }

  async geoRemove(key: string, member: string): Promise<void> {
    await this.client.zrem(key, member);
  }

  async geoPos(
    key: string,
    member: string,
  ): Promise<{ longitude: number; latitude: number } | null> {
    const result = await this.client.geopos(key, member);
    if (result && result[0]) {
      const [lng, lat] = result[0] as [string, string];
      return { longitude: parseFloat(lng), latitude: parseFloat(lat) };
    }
    return null;
  }

  // ─── Distributed Lock ───────────────────────────────
  async acquireLock(key: string, ttlSeconds: number = 30): Promise<boolean> {
    const lockKey = `lock:${key}`;
    const result = await this.client.set(lockKey, '1', 'EX', ttlSeconds, 'NX');
    return result === 'OK';
  }

  async releaseLock(key: string): Promise<void> {
    await this.client.del(`lock:${key}`);
  }

  // ─── Pub/Sub ─────────────────────────────────────────
  async publish(channel: string, message: string): Promise<void> {
    await this.client.publish(channel, message);
  }

  // ─── Health Check ───────────────────────────────────
  async ping(): Promise<boolean> {
    try {
      const result = await this.client.ping();
      return result === 'PONG';
    } catch {
      return false;
    }
  }
}
