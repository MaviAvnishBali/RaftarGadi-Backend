import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AppConfigService {
  constructor(private readonly configService: ConfigService) {
    this.validateRequiredConfig();
  }

  private validateRequiredConfig(): void {
    const required = ['DATABASE_URL', 'JWT_ACCESS_SECRET', 'JWT_REFRESH_SECRET'];
    const missing = required.filter((key) => !this.configService.get(key));
    if (missing.length > 0) {
      throw new Error(`Missing required environment variables: ${missing.join(', ')}`);
    }
  }

  // ─── Application ─────────────────────────────────────
  get nodeEnv(): string {
    return this.configService.get<string>('NODE_ENV', 'development');
  }

  get port(): number {
    return this.configService.get<number>('PORT', 3000);
  }

  get isProduction(): boolean {
    return this.nodeEnv === 'production';
  }

  // ─── Database ────────────────────────────────────────
  get databaseUrl(): string {
    return this.configService.getOrThrow<string>('DATABASE_URL');
  }

  // ─── Redis ───────────────────────────────────────────
  get redisHost(): string {
    return this.configService.get<string>('REDIS_HOST', 'localhost');
  }

  get redisPort(): number {
    return this.configService.get<number>('REDIS_PORT', 6379);
  }

  get redisPassword(): string {
    return this.configService.get<string>('REDIS_PASSWORD', '');
  }

  get redisDb(): number {
    return this.configService.get<number>('REDIS_DB', 0);
  }

  // ─── JWT ─────────────────────────────────────────────
  get jwtAccessSecret(): string {
    return this.configService.getOrThrow<string>('JWT_ACCESS_SECRET');
  }

  get jwtAccessExpiration(): string {
    return this.configService.get<string>('JWT_ACCESS_EXPIRATION', '15m');
  }

  get jwtRefreshSecret(): string {
    return this.configService.getOrThrow<string>('JWT_REFRESH_SECRET');
  }

  get jwtRefreshExpiration(): string {
    return this.configService.get<string>('JWT_REFRESH_EXPIRATION', '30d');
  }

  // ─── OTP ─────────────────────────────────────────────
  get otpExpiry(): number {
    return this.configService.get<number>('OTP_EXPIRY_SECONDS', 300);
  }

  get otpMaxAttempts(): number {
    return this.configService.get<number>('OTP_MAX_ATTEMPTS', 3);
  }

  get otpLength(): number {
    return this.configService.get<number>('OTP_LENGTH', 6);
  }

  // ─── Driver Matching ────────────────────────────────
  get driverSearchRadius(): number {
    return this.configService.get<number>('DRIVER_SEARCH_RADIUS_KM', 5);
  }

  get driverSearchMaxResults(): number {
    return this.configService.get<number>('DRIVER_SEARCH_MAX_RESULTS', 20);
  }

  get driverRequestTimeout(): number {
    return this.configService.get<number>('DRIVER_REQUEST_TIMEOUT_SECONDS', 30);
  }

  // ─── Platform ────────────────────────────────────────
  get platformCommissionPercent(): number {
    return this.configService.get<number>('PLATFORM_COMMISSION_PERCENT', 15);
  }

  // ─── Logging ─────────────────────────────────────────
  get logLevel(): string {
    return this.configService.get<string>('LOG_LEVEL', 'info');
  }
}
