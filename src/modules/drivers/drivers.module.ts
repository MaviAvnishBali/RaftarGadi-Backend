import { Module } from '@nestjs/common';
import { DriversController } from './controllers/drivers.controller';
import { DriversService } from './services/drivers.service';
import { DriversRepository } from './repositories/drivers.repository';
import { KycVerificationService } from './services/kyc-verification.service';

@Module({
  controllers: [DriversController],
  providers: [DriversService, DriversRepository, KycVerificationService],
  exports: [DriversService],
})
export class DriversModule {}
