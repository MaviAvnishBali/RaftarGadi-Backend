import { Controller, Get } from '@nestjs/common';
import { HealthCheck, HealthCheckService } from '@nestjs/terminus';
import { ApiTags } from '@nestjs/swagger';
import { Public } from '../../common/decorators';
import { PrismaService } from '../../database/prisma.service';
import { RedisService } from '../../config/redis.service';

@ApiTags('Health')
@Controller('health')
export class HealthController {
  constructor(
    private health: HealthCheckService,
    private prismaService: PrismaService,
    private redisService: RedisService,
  ) {}

  @Get()
  @Public()
  @HealthCheck()
  check() {
    return this.health.check([() => this.checkDatabase(), () => this.checkRedis()]);
  }

  @Get('live')
  @Public()
  liveness() {
    return { status: 'ok', timestamp: new Date().toISOString() };
  }

  @Get('ready')
  @Public()
  @HealthCheck()
  readiness() {
    return this.health.check([() => this.checkDatabase(), () => this.checkRedis()]);
  }

  private async checkDatabase(): Promise<import('@nestjs/terminus').HealthIndicatorResult> {
    try {
      await this.prismaService.$queryRaw`SELECT 1`;
      return { database: { status: 'up' } };
    } catch {
      return { database: { status: 'down' } };
    }
  }

  private async checkRedis(): Promise<import('@nestjs/terminus').HealthIndicatorResult> {
    const isHealthy = await this.redisService.ping();
    return { redis: { status: isHealthy ? 'up' : 'down' } };
  }
}
