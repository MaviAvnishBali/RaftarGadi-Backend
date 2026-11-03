import { Test, TestingModule } from '@nestjs/testing';
import { DriversService } from '../services/drivers.service';
import { DriversRepository } from '../repositories/drivers.repository';
import { KycVerificationService } from '../services/kyc-verification.service';
import { RedisService } from '../../../config/redis.service';

describe('DriversService - KYC Submission', () => {
  let service: DriversService;
  let repo: any;
  let redisService: any;

  beforeEach(async () => {
    repo = {
      findByUserId: jest.fn(),
      create: jest.fn(),
      update: jest.fn(),
    };

    redisService = {
      client: {
        get: jest.fn(),
        set: jest.fn(),
        geoadd: jest.fn(),
        zrem: jest.fn(),
        del: jest.fn(),
      },
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        DriversService,
        KycVerificationService,
        { provide: DriversRepository, useValue: repo },
        { provide: RedisService, useValue: redisService },
      ],
    }).compile();

    service = module.get<DriversService>(DriversService);
  });

  it('should mask Aadhaar and store driver KYC details with SUBMITTED status', async () => {
    const mockDriver = {
      id: 'driver-uuid-123',
      userId: 'user-uuid-456',
      licenseNumber: 'DL1420110012345',
      maskedAadhaar: 'XXXXXXXX5678',
      aadhaarName: 'Ramesh Kumar',
      kycStatus: 'SUBMITTED',
    };

    repo.findByUserId.mockResolvedValue(mockDriver);
    repo.update.mockResolvedValue(mockDriver);

    const dto = {
      licenseNumber: 'DL1420110012345',
      dob: '1995-05-20',
      aadhaarNumber: '548912345678',
      aadhaarName: 'Ramesh Kumar',
    };

    const result = await service.submitKycDetails('user-uuid-456', dto);

    expect(result.success).toBe(true);
    expect(result.driver.maskedAadhaar).toBe('XXXXXXXX5678');
    expect(repo.update).toHaveBeenCalledWith(
      'driver-uuid-123',
      expect.objectContaining({
        licenseNumber: 'DL1420110012345',
        maskedAadhaar: 'XXXXXXXX5678',
        aadhaarNumber: '548912345678',
        aadhaarName: 'Ramesh Kumar',
        kycStatus: 'SUBMITTED',
      }),
    );
  });
});
