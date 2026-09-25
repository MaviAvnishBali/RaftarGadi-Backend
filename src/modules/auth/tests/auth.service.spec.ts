import { UserRole } from '@prisma/client';
import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from '../services/auth.service';
import { UsersService } from '../../users/services/users.service';
import { JwtService } from '@nestjs/jwt';
import { RedisService } from '@config/redis.service';
import { AppConfigService } from '@config/config.service';
import { PrismaService } from '@database/prisma.service';
import { Role } from '@common/enums';
import { AppException } from '@common/exceptions';

describe('AuthService', () => {
  let service: AuthService;
  let redisService: RedisService;
  let prisma: PrismaService;

  const mockUsersService = {
    findOrCreateByPhone: jest.fn(),
  };

  const mockJwtService = {
    sign: jest.fn().mockReturnValue('mock-jwt-token'),
  };

  const mockRedisService = {
    set: jest.fn(),
    get: jest.fn(),
    del: jest.fn(),
  };

  const mockAppConfigService = {
    get: jest.fn((key: string) => {
      if (key === 'OTP_LENGTH') return 6;
      if (key === 'OTP_TTL') return 300;
      if (key === 'OTP_MAX_ATTEMPTS') return 5;
      return null;
    }),
  };

  const mockPrismaService = {
    refreshToken: {
      create: jest.fn(),
      findFirst: jest.fn(),
      delete: jest.fn(),
      deleteMany: jest.fn(),
    },
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        { provide: UsersService, useValue: mockUsersService },
        { provide: JwtService, useValue: mockJwtService },
        { provide: RedisService, useValue: mockRedisService },
        { provide: AppConfigService, useValue: mockAppConfigService },
        { provide: PrismaService, useValue: mockPrismaService },
      ],
    }).compile();

    service = module.get<AuthService>(AuthService);
    redisService = module.get<RedisService>(RedisService);
    prisma = module.get<PrismaService>(PrismaService);

    jest.clearAllMocks();
  });

  describe('sendOtp', () => {
    it('should generate and store OTP in Redis', async () => {
      const result = await service.sendOtp('9999999999');
      expect(result.message).toBe('OTP sent successfully');
      expect(mockRedisService.set).toHaveBeenCalledWith('otp:9999999999', expect.any(String), 300);
      expect(mockRedisService.del).toHaveBeenCalledWith('otp_attempts:9999999999');
    });
  });

  describe('verifyOtp', () => {
    const phone = '9999999999';
    const otp = '123456';
    const mockUser = { id: 'u1', phone, role: Role.CUSTOMER, name: 'John' };

    it('should throw if max attempts reached', async () => {
      mockRedisService.get.mockResolvedValueOnce('5'); // attempts
      await expect(service.verifyOtp(phone, otp, Role.CUSTOMER)).rejects.toThrow(AppException);
    });

    it('should throw if OTP is expired/invalid', async () => {
      mockRedisService.get.mockResolvedValueOnce('0'); // attempts
      mockRedisService.get.mockResolvedValueOnce(null); // otp missing
      await expect(service.verifyOtp(phone, otp, Role.CUSTOMER)).rejects.toThrow(
        'OTP expired or invalid',
      );
    });

    it('should throw and increment attempts on wrong OTP', async () => {
      mockRedisService.get.mockResolvedValueOnce('0'); // attempts
      mockRedisService.get.mockResolvedValueOnce('654321'); // stored otp
      await expect(service.verifyOtp(phone, otp, Role.CUSTOMER)).rejects.toThrow('Invalid OTP');
      expect(mockRedisService.set).toHaveBeenCalledWith('otp_attempts:9999999999', '1', 300);
    });

    it('should return tokens on successful verification', async () => {
      mockRedisService.get.mockResolvedValueOnce('0'); // attempts
      mockRedisService.get.mockResolvedValueOnce(otp); // stored otp
      mockUsersService.findOrCreateByPhone.mockResolvedValueOnce(mockUser);
      mockPrismaService.refreshToken.create.mockResolvedValueOnce({ id: 'rt1' });

      const result = await service.verifyOtp(phone, otp, Role.CUSTOMER);

      expect(result.accessToken).toBe('mock-jwt-token');
      expect(result.refreshToken).toBeDefined();
      expect(result.user.id).toBe(mockUser.id);
      expect(mockRedisService.del).toHaveBeenCalledWith(`otp:${phone}`);
    });
  });

  describe('refreshTokens', () => {
    const oldToken = 'old-refresh-token';
    const mockUser = { id: 'u1', phone: '999', role: Role.CUSTOMER, name: 'John' };

    it('should throw if token is invalid', async () => {
      mockPrismaService.refreshToken.findFirst.mockResolvedValueOnce(null);
      await expect(service.refreshTokens(oldToken)).rejects.toThrow('Invalid refresh token');
    });

    it('should throw if token is expired', async () => {
      const expiredDate = new Date();
      expiredDate.setDate(expiredDate.getDate() - 1); // yesterday

      mockPrismaService.refreshToken.findFirst.mockResolvedValueOnce({
        id: 't1',
        expiresAt: expiredDate,
        user: mockUser,
      });

      await expect(service.refreshTokens(oldToken)).rejects.toThrow('Refresh token expired');
      expect(mockPrismaService.refreshToken.delete).toHaveBeenCalledWith({ where: { id: 't1' } });
    });

    it('should return new tokens for valid refresh token', async () => {
      const futureDate = new Date();
      futureDate.setDate(futureDate.getDate() + 1);

      mockPrismaService.refreshToken.findFirst.mockResolvedValueOnce({
        id: 't1',
        expiresAt: futureDate,
        user: mockUser,
      });

      const result = await service.refreshTokens(oldToken);

      expect(mockPrismaService.refreshToken.delete).toHaveBeenCalledWith({ where: { id: 't1' } });
      expect(mockPrismaService.refreshToken.create).toHaveBeenCalled();
      expect(result.accessToken).toBe('mock-jwt-token');
      expect(result.refreshToken).toBeDefined();
    });
  });

  describe('logout', () => {
    it('should revoke refresh token', async () => {
      await service.logout('u1', 'token-123');
      expect(mockPrismaService.refreshToken.deleteMany).toHaveBeenCalled();
    });
  });
});
