import { Module } from '@nestjs/common';
import { DriversController } from './controllers/drivers.controller';
import { DriversService } from './services/drivers.service';
import { DriversRepository } from './repositories/drivers.repository';
import { KycVerificationService } from './services/kyc-verification.service';
import { DriverLivenessService } from './services/driver-liveness.service';

@Module({
  controllers: [DriversController],
  providers: [
    DriversService,
    DriversRepository,
    KycVerificationService,
    DriverLivenessService,
  ],
  exports: [DriversService, DriverLivenessService],
})
export class DriversModule {}
