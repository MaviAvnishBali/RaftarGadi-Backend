import { Module } from '@nestjs/common';
import { DriversController } from './controllers/drivers.controller';
import { DriversService } from './services/drivers.service';
import { DriversRepository } from './repositories/drivers.repository';

@Module({
  controllers: [DriversController],
  providers: [DriversService, DriversRepository],
  exports: [DriversService],
})
export class DriversModule {}
