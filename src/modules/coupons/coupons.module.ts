import { Module } from '@nestjs/common';
import { CouponsController } from './controllers/coupons.controller';
import { CouponsService } from './services/coupons.service';
import { CouponsRepository } from './repositories/coupons.repository';

@Module({
  controllers: [CouponsController],
  providers: [CouponsService, CouponsRepository],
  exports: [CouponsService],
})
export class CouponsModule {}
