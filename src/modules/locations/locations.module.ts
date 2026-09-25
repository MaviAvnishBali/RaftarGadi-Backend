import { Module } from '@nestjs/common';
import { LocationsService } from './services/locations.service';
import { LocationGateway } from './gateways/location.gateway';
import { JwtModule } from '@nestjs/jwt';

@Module({
  imports: [JwtModule.register({})],
  providers: [LocationsService, LocationGateway],
  exports: [LocationsService, LocationGateway],
})
export class LocationsModule {}
