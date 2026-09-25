import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { ThrottlerModule } from '@nestjs/throttler';
import { EventEmitterModule } from '@nestjs/event-emitter';
import { LoggerModule } from 'nestjs-pino';
import { APP_GUARD } from '@nestjs/core';

import { AppConfigModule } from './config/config.module';
import { DatabaseModule } from './database/database.module';
import { RedisModule } from './config/redis.module';
import { JwtModule } from '@nestjs/jwt';
import { HealthModule } from './modules/health/health.module';
import { AuthModule } from './modules/auth/auth.module';
import { UsersModule } from './modules/users/users.module';
import { CustomersModule } from './modules/customers/customers.module';
import { DriversModule } from './modules/drivers/drivers.module';
import { VehiclesModule } from './modules/vehicles/vehicles.module';
import { BookingsModule } from './modules/bookings/bookings.module';
import { PricingModule } from './modules/pricing/pricing.module';
import { LocationsModule } from './modules/locations/locations.module';
import { PaymentsModule } from './modules/payments/payments.module';
import { WalletsModule } from './modules/wallets/wallets.module';
import { NotificationsModule } from './modules/notifications/notifications.module';
import { RatingsModule } from './modules/ratings/ratings.module';
import { CouponsModule } from './modules/coupons/coupons.module';
import { SupportModule } from './modules/support/support.module';
import { ReportsModule } from './modules/reports/reports.module';
import { AdminModule } from './modules/admin/admin.module';
import { JwtAuthGuard } from './common/guards/jwt-auth.guard';
import { RolesGuard } from './common/guards/roles.guard';
import { PermissionsGuard } from './common/guards/permissions.guard';
import { JobsModule } from './jobs/jobs.module';

@Module({
  imports: [
    // Configuration
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: [`.env.${process.env.NODE_ENV || 'development'}`, '.env'],
    }),

    // Structured Logging
    LoggerModule.forRoot({
      pinoHttp: {
        level: process.env.LOG_LEVEL || 'info',
        transport:
          process.env.NODE_ENV !== 'production'
            ? {
                target: 'pino-pretty',
                options: {
                  colorize: true,
                  singleLine: true,
                  translateTime: 'SYS:standard',
                },
              }
            : undefined,
        autoLogging: true,
        redact: {
          paths: [
            'req.headers.authorization',
            'req.body.otp',
            'req.body.password',
            'req.body.refreshToken',
            'req.body.token',
          ],
          censor: '[REDACTED]',
        },
        serializers: {
          req: (req: Record<string, unknown>) => ({
            method: req.method,
            url: req.url,
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            remoteAddress: (req.raw as any)?.socket?.remoteAddress,
          }),
        },
      },
    }),

    // Rate Limiting
    ThrottlerModule.forRoot([
      {
        ttl: parseInt(process.env.THROTTLE_TTL || '60000', 10),
        limit: parseInt(process.env.THROTTLE_LIMIT || '100', 10),
      },
    ]),

    // Event Emitter for domain events
    EventEmitterModule.forRoot({
      wildcard: true,
      delimiter: '.',
      maxListeners: 20,
      verboseMemoryLeak: true,
    }),

    // Core infrastructure
    AppConfigModule,
    DatabaseModule,
    RedisModule,
    JwtModule.register({ global: true }),

    // Feature modules
    HealthModule,
    AuthModule,
    UsersModule,
    CustomersModule,
    DriversModule,
    VehiclesModule,
    BookingsModule,
    PricingModule,
    LocationsModule,
    PaymentsModule,
    WalletsModule,
    NotificationsModule,
    RatingsModule,
    CouponsModule,
    SupportModule,
    ReportsModule,
    AdminModule,

    // Background jobs
    JobsModule,
  ],
  providers: [
    // Global guards — applied to all routes
    {
      provide: APP_GUARD,
      useClass: JwtAuthGuard,
    },
    {
      provide: APP_GUARD,
      useClass: RolesGuard,
    },
    {
      provide: APP_GUARD,
      useClass: PermissionsGuard,
    },
  ],
})
export class AppModule {}
