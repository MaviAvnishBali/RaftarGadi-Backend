import { Module } from '@nestjs/common';
import { VehiclesController } from './controllers/vehicles.controller';
import { VehiclesService } from './services/vehicles.service';
import { VehiclesRepository } from './repositories/vehicles.repository';
import { LocationsModule } from '../locations/locations.module';
import { ServiceableAreasModule } from '../serviceable-areas/serviceable-areas.module';

@Module({
  imports: [LocationsModule, ServiceableAreasModule],
  controllers: [VehiclesController],
  providers: [VehiclesService, VehiclesRepository],
  exports: [VehiclesService],
})
export class VehiclesModule {}
