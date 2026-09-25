import { Injectable, Logger } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../../users/services/users.service';
import { RedisService } from '@config/redis.service';
import { AppConfigService } from '@config/config.service';
import { PrismaService } from '@database/prisma.service';
import { AppException } from '@common/exceptions';
import { AuthTokens } from '../interfaces/auth-tokens.interface';
import { Role } from '@common/enums';
import * as crypto from 'crypto';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);

  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
    private readonly redisService: RedisService,
    private readonly configService: AppConfigService,
    private readonly prisma: PrismaService,
  ) {}

  async sendOtp(phone: string): Promise<{ message: string }> {
    const otpLength = this.configService.otpLength || 6;
    const otp = this.generateRandomOtp(otpLength);
    const otpKey = `otp:${phone}`;
    const attemptsKey = `otp_attempts:${phone}`;
    const ttl = this.configService.otpExpiry || 300;

    await this.redisService.set(otpKey, otp, ttl);
    await this.redisService.del(attemptsKey);

    if (process.env.NODE_ENV !== 'production') {
      this.logger.log(`Development Mode - OTP for ${phone}: ${otp}`);
    }

    return { message: 'OTP sent successfully' };
  }

  async verifyOtp(
    phone: string,
    otp: string,
    role: Role,
    deviceInfo?: string,
    ip?: string,
  ): Promise<AuthTokens> {
    const otpKey = `otp:${phone}`;
    const attemptsKey = `otp_attempts:${phone}`;
    const maxAttempts = this.configService.otpMaxAttempts || 3;

    const attemptsStr = await this.redisService.get(attemptsKey);
    const attempts = parseInt(attemptsStr || '0', 10);

    if (attempts >= maxAttempts) {
      throw new AppException('ERROR', 'Max OTP attempts reached. Try again later.', 429);
    }

    const isDevBypass = process.env.NODE_ENV !== 'production' && otp === '123456';

    if (!isDevBypass) {
      const storedOtp = await this.redisService.get(otpKey);
      if (!storedOtp) {
        throw new AppException('ERROR', 'OTP expired or invalid', 400);
      }

      if (storedOtp !== otp) {
        await this.redisService.set(attemptsKey, (attempts + 1).toString(), 300);
        throw new AppException('ERROR', 'Invalid OTP', 400);
      }
    }

    await this.redisService.del(otpKey);
    await this.redisService.del(attemptsKey);

    const user = await this.usersService.findOrCreateByPhone(phone, role);

    const accessToken = this.generateAccessToken(user);
    const refreshToken = await this.generateRefreshToken(user.id, deviceInfo, ip);

    return {
      accessToken,
      refreshToken,
      expiresIn: 3600,
      user: {
        id: user.id,
        phone: user.phone,
        role: user.role,
        fullName: user.name || 'Raftar User',
        isPhoneVerified: true,
      },
    };
  }

  async refreshTokens(refreshToken: string, deviceInfo?: string, ip?: string): Promise<AuthTokens> {
    const { tokenData, user } = await this.validateRefreshToken(refreshToken);

    await this.prisma.refreshToken.delete({ where: { id: tokenData.id } });

    const newAccessToken = this.generateAccessToken(user);
    const newRefreshToken = await this.generateRefreshToken(user.id, deviceInfo, ip);

    return {
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,
      expiresIn: 3600,
      user: {
        id: user.id,
        phone: user.phone,
        role: user.role,
        fullName: user.name || 'Raftar User',
        isPhoneVerified: true,
      },
    };
  }

  async logout(userId: string, refreshToken: string): Promise<void> {
    const tokenHash = this.hashToken(refreshToken);
    await this.prisma.refreshToken.deleteMany({
      where: { userId, tokenHash: tokenHash },
    });
  }

  async logoutAll(userId: string): Promise<void> {
    await this.prisma.refreshToken.deleteMany({
      where: { userId },
    });
  }

  private generateAccessToken(user: any): string {
    const payload = { sub: user.id, role: user.role, phone: user.phone };
    return this.jwtService.sign(payload);
  }

  private async generateRefreshToken(
    userId: string,
    deviceInfo?: string,
    ip?: string,
  ): Promise<string> {
    const token = uuidv4();
    const tokenHash = this.hashToken(token);
    const expiresAt = new Date();
    expiresAt.setDate(expiresAt.getDate() + 7);

    await this.prisma.refreshToken.create({
      data: {
        tokenHash,
        userId,
        deviceInfo,
        ipAddress: ip,
        expiresAt,
      },
    });

    return token;
  }

  private async validateRefreshToken(token: string) {
    const tokenHash = this.hashToken(token);

    const tokenData = await this.prisma.refreshToken.findFirst({
      where: { tokenHash },
      include: { user: true },
    });

    if (!tokenData) {
      throw new AppException('ERROR', 'Invalid refresh token', 401);
    }

    if (tokenData.expiresAt < new Date()) {
      await this.prisma.refreshToken.delete({ where: { id: tokenData.id } });
      throw new AppException('ERROR', 'Refresh token expired', 401);
    }

    return { tokenData, user: tokenData.user };
  }

  private hashToken(token: string): string {
    return crypto.createHash('sha256').update(token).digest('hex');
  }

  private generateRandomOtp(length: number): string {
    const chars = '0123456789';
    let otp = '';
    for (let i = 0; i < length; i++) {
      otp += chars[Math.floor(Math.random() * chars.length)];
    }
    return otp;
  }
}
