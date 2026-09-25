import { Test, TestingModule } from '@nestjs/testing';
import { PricingService } from '../services/pricing.service';
import { PricingRepository } from '../repositories/pricing.repository';

describe('PricingService', () => {
  let service: PricingService;
  let repo: PricingRepository;

  const mockPricingRepository = {
    getActiveRule: jest.fn(),
  };

  const mockRule = {
    baseFare: 50,
    perKmCharge: 10,
    perMinCharge: 2,
    minimumFare: 100,
    surgeMultiplier: 1.0,
    platformFeePercent: 5,
    taxPercent: 5,
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [PricingService, { provide: PricingRepository, useValue: mockPricingRepository }],
    }).compile();

    service = module.get<PricingService>(PricingService);
    repo = module.get<PricingRepository>(PricingRepository);
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('calculateEstimatedFare', () => {
    it('should calculate basic fare correctly', async () => {
      mockPricingRepository.getActiveRule.mockResolvedValueOnce(mockRule);

      const dto = { vehicleTypeId: 'v1', distanceKm: 10, durationMin: 20 };
      // baseFare = 50
      // distanceCharge = 10 * 10 = 100
      // timeCharge = 20 * 2 = 40
      // subtotal = 190
      // surgeAmount = 0
      // discount = 0
      // platformFee = 190 * 0.05 = 9.5
      // tax = (190 + 9.5) * 0.05 = 9.98
      // total = 190 + 9.5 + 9.98 = 209.48
      const result = await service.calculateEstimatedFare(dto);

      expect(result.baseFare).toBe(50);
      expect(result.distanceCharge).toBe(100);
      expect(result.timeCharge).toBe(40);
      expect(result.subtotal).toBe(190);
      expect(result.platformFee).toBe(9.5);
      expect(result.taxAmount).toBe(9.98);
      expect(result.totalFare).toBe(209.48);
      expect(result.minimumFareApplied).toBe(false);
    });

    it('should enforce minimum fare', async () => {
      mockPricingRepository.getActiveRule.mockResolvedValueOnce(mockRule);

      const dto = { vehicleTypeId: 'v1', distanceKm: 1, durationMin: 5 };
      // base = 50, dist = 10, time = 10, sub = 70
      // plat = 3.5, tax = (73.5) * 0.05 = 3.68
      // total = 77.18 -> which is < 100
      const result = await service.calculateEstimatedFare(dto);

      expect(result.totalFare).toBe(100);
      expect(result.minimumFareApplied).toBe(true);
    });

    it('should apply surge multiplier correctly', async () => {
      mockPricingRepository.getActiveRule.mockResolvedValueOnce({
        ...mockRule,
        surgeMultiplier: 1.5,
      });

      const dto = { vehicleTypeId: 'v1', distanceKm: 10, durationMin: 20 };
      // base = 50, dist = 100, time = 40 -> initial sub = 190
      // surgeAmount = 190 * 0.5 = 95
      // subtotal = 285
      const result = await service.calculateEstimatedFare(dto);

      expect(result.subtotal).toBe(285);
      expect(result.surgeMultiplier).toBe(1.5);
      expect(result.surgeAmount).toBe(95);
    });

    it('should apply 10% discount if couponCode provided', async () => {
      mockPricingRepository.getActiveRule.mockResolvedValueOnce(mockRule);

      const dto = { vehicleTypeId: 'v1', distanceKm: 10, durationMin: 20, couponCode: 'SAVE10' };
      // initial sub = 190
      // discount = 19
      // platFee = (190 - 19) * 0.05 = 8.55
      // tax = (190 - 19 + 8.55) * 0.05 = 8.98
      // total = 171 + 8.55 + 8.98 = 188.53
      const result = await service.calculateEstimatedFare(dto);

      expect(result.discountAmount).toBe(19);
      expect(result.totalFare).toBe(188.53);
    });

    it('should calculate correctly with zero distance', async () => {
      mockPricingRepository.getActiveRule.mockResolvedValueOnce(mockRule);

      const dto = { vehicleTypeId: 'v1', distanceKm: 0, durationMin: 5 };
      const result = await service.calculateEstimatedFare(dto);

      expect(result.distanceCharge).toBe(0);
      expect(result.timeCharge).toBe(10);
      expect(result.baseFare).toBe(50);
    });
  });
});
