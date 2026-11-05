import { Module } from '@nestjs/common';
import { LocationsService } from './services/locations.service';
import { LocationGateway } from './gateways/location.gateway';
import { LocationsController } from './controllers/locations.controller';
import { JwtModule } from '@nestjs/jwt';
import { AppConfigService } from '@config/config.service';

@Module({
  imports: [
    JwtModule.registerAsync({
      inject: [AppConfigService],
      useFactory: (configService: AppConfigService) => ({
        secret: configService.jwtAccessSecret,
        signOptions: { expiresIn: configService.jwtAccessExpiration },
      }),
    }),
  ],
  controllers: [LocationsController],
  providers: [LocationsService, LocationGateway],
  exports: [LocationsService, LocationGateway],
})
export class LocationsModule {}
