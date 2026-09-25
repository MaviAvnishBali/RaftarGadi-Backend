import { Module } from '@nestjs/common';
import { TerminusModule } from '@nestjs/terminus';
import { HealthController } from './health.controller';
import { PrismaService } from '../../database/prisma.service';
import { RedisService } from '../../config/redis.service';

@Module({
  imports: [TerminusModule],
  controllers: [HealthController],
  providers: [PrismaService, RedisService],
})
export class HealthModule {}
