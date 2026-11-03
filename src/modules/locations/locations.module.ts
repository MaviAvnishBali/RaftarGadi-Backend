import { Module } from '@nestjs/common';
import { LocationsService } from './services/locations.service';
import { LocationGateway } from './gateways/location.gateway';
import { LocationsController } from './controllers/locations.controller';
import { JwtModule } from '@nestjs/jwt';

@Module({
  imports: [JwtModule.register({})],
  controllers: [LocationsController],
  providers: [LocationsService, LocationGateway],
  exports: [LocationsService, LocationGateway],
})
export class LocationsModule {}
