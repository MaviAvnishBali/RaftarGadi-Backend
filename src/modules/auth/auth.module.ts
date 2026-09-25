import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { AuthService } from './services/auth.service';
import { AuthController } from './controllers/auth.controller';
import { UsersModule } from '../users/users.module';
import { AppConfigService } from '@config/config.service';
import { PrismaService } from '@database/prisma.service';
import { RedisService } from '@config/redis.service';

@Module({
  imports: [
    UsersModule,
    JwtModule.registerAsync({
      inject: [AppConfigService],
      useFactory: (configService: AppConfigService) => ({
        secret: configService.jwtAccessSecret,
        signOptions: { expiresIn: configService.jwtAccessExpiration },
      }),
    }),
  ],
  controllers: [AuthController],
  providers: [AuthService, PrismaService, RedisService],
  exports: [AuthService],
})
export class AuthModule {}
