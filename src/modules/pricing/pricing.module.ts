import { Module } from '@nestjs/common';
import { PricingService } from './services/pricing.service';
import { PricingController } from './controllers/pricing.controller';
import { PricingRepository } from './repositories/pricing.repository';
import { PrismaService } from '../../database/prisma.service';

@Module({
  controllers: [PricingController],
  providers: [PricingService, PricingRepository, PrismaService],
  exports: [PricingService],
})
export class PricingModule {}
