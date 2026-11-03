import { Test, TestingModule } from '@nestjs/testing';
import { ServiceableAreasService } from '../services/serviceable-areas.service';
import { PrismaService } from '../../../database/prisma.service';
import { AppException } from '../../../common/exceptions/app.exception';

describe('ServiceableAreasService', () => {
  let service: ServiceableAreasService;
  let prisma: any;

  const mockDelhi = {
    id: 'area-delhi-1',
    name: 'New Delhi',
    state: 'Delhi NCR',
    centerLat: 28.6139,
    centerLng: 77.2090,
    radiusKm: 35.0,
    isActive: true,
    createdAt: new Date(),
    updatedAt: new Date(),
  };

  const mockNoida = {
    id: 'area-noida-1',
    name: 'Noida',
    state: 'Uttar Pradesh',
    centerLat: 28.5355,
    centerLng: 77.3910,
    radiusKm: 25.0,
    isActive: true,
    createdAt: new Date(),
    updatedAt: new Date(),
  };

  beforeEach(async () => {
    prisma = {
      serviceableArea: {
        findMany: jest.fn().mockResolvedValue([mockDelhi, mockNoida]),
        findUnique: jest.fn(),
        create: jest.fn(),
        update: jest.fn(),
        delete: jest.fn(),
        count: jest.fn().mockResolvedValue(2),
      },
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ServiceableAreasService,
        { provide: PrismaService, useValue: prisma },
      ],
    }).compile();

    service = module.get<ServiceableAreasService>(ServiceableAreasService);
  });

  describe('calculateHaversineDistanceKm', () => {
    it('should compute distance between Connaught Place and India Gate accurately (~2.5km)', () => {
      const dist = service.calculateHaversineDistanceKm(28.6315, 77.2167, 28.6129, 77.2295);
      expect(dist).toBeGreaterThan(2.0);
      expect(dist).toBeLessThan(3.5);
    });

    it('should return 0 when comparing identical points', () => {
      const dist = service.calculateHaversineDistanceKm(28.6139, 77.2090, 28.6139, 77.2090);
      expect(dist).toBe(0);
    });
  });

  describe('findServingArea', () => {
    it('should return matching operational area when coordinates are within radius', async () => {
      // Connaught Place is ~2.1 km from New Delhi center (radius 35 km)
      const match = await service.findServingArea(28.6315, 77.2167);
      expect(match).toBeDefined();
      expect(match?.area.name).toBe('New Delhi');
      expect(match?.distanceKm).toBeLessThan(5);
    });

    it('should return null when coordinates are far outside all active areas', async () => {
      // Coordinate in the ocean (0, 0)
      const match = await service.findServingArea(0.0, 0.0);
      expect(match).toBeNull();
    });

    it('should return null when area exists but isActive is false', async () => {
      prisma.serviceableArea.findMany.mockResolvedValue([
        { ...mockDelhi, isActive: false },
      ]);

      const match = await service.findServingArea(28.6315, 77.2167);
      expect(match).toBeNull();
    });

    it('should NOT allow New Delhi to override an explicitly disabled Gurugram area', async () => {
      const mockGurugram = {
        id: 'area-ggn-1',
        name: 'Gurugram',
        state: 'Haryana',
        centerLat: 28.4595,
        centerLng: 77.0266,
        radiusKm: 30.0,
        isActive: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      prisma.serviceableArea.findMany.mockResolvedValue([mockDelhi, mockGurugram]);

      // Sector 49 Gurugram: 5.45 km from Gurugram center, 27.56 km from Delhi center
      const match = await service.findServingArea(28.4128, 77.0442);
      expect(match).toBeNull();
    });
  });

  describe('validateServiceability', () => {
    it('should resolve successfully when pickup point is within active serviceable area', async () => {
      const area = await service.validateServiceability(28.6315, 77.2167, 'Connaught Place');
      expect(area.name).toBe('New Delhi');
    });

    it('should throw AREA_NOT_SERVICEABLE when pickup point is outside active areas', async () => {
      prisma.serviceableArea.findMany.mockResolvedValue([]);

      await expect(
        service.validateServiceability(51.5074, -0.1278, 'London, UK'),
      ).rejects.toThrow(AppException);

      try {
        await service.validateServiceability(51.5074, -0.1278, 'London, UK');
      } catch (err: any) {
        expect(err.errorCode).toBe('AREA_NOT_SERVICEABLE');
        expect(err.message).toContain('Service is not yet available in your area');
      }
    });

    it('should throw descriptive exception when location is in disabled Gurugram', async () => {
      const mockGurugram = {
        id: 'area-ggn-1',
        name: 'Gurugram',
        state: 'Haryana',
        centerLat: 28.4595,
        centerLng: 77.0266,
        radiusKm: 30.0,
        isActive: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      prisma.serviceableArea.findMany.mockResolvedValue([mockDelhi, mockGurugram]);

      // Pickup validation
      try {
        await service.validateServiceability(28.4128, 77.0442, 'Sector 49, Gurugram', 'pickup');
        fail('Expected exception was not thrown');
      } catch (err: any) {
        expect(err.errorCode).toBe('AREA_NOT_SERVICEABLE');
        expect(err.message).toContain('Service is currently disabled in Gurugram by administrator');
        expect(err.message).toContain('Pickup location cannot be booked');
      }

      // Drop validation
      try {
        await service.validateServiceability(28.4950, 77.0895, 'DLF Cyber City, Gurugram', 'drop');
        fail('Expected exception was not thrown');
      } catch (err: any) {
        expect(err.errorCode).toBe('AREA_NOT_SERVICEABLE');
        expect(err.message).toContain('Service is currently disabled in Gurugram by administrator');
        expect(err.message).toContain('Drop location cannot be booked');
      }
    });
  });

  describe('CRUD operations', () => {
    it('should create a new serviceable area', async () => {
      const dto = {
        name: 'Chandigarh',
        state: 'Punjab / Haryana',
        centerLat: 30.7333,
        centerLng: 76.7794,
        radiusKm: 25.0,
        isActive: true,
      };

      prisma.serviceableArea.create.mockResolvedValue({ id: 'area-chd-1', ...dto });

      const created = await service.createArea(dto);
      expect(created.name).toBe('Chandigarh');
      expect(prisma.serviceableArea.create).toHaveBeenCalledWith({
        data: dto,
      });
    });

    it('should toggle active status of an area', async () => {
      prisma.serviceableArea.findUnique.mockResolvedValue(mockDelhi);
      prisma.serviceableArea.update.mockResolvedValue({ ...mockDelhi, isActive: false });

      const updated = await service.toggleActive('area-delhi-1', false);
      expect(updated.isActive).toBe(false);
      expect(prisma.serviceableArea.update).toHaveBeenCalledWith({
        where: { id: 'area-delhi-1' },
        data: { isActive: false },
      });
    });

    it('should delete an area', async () => {
      prisma.serviceableArea.findUnique.mockResolvedValue(mockDelhi);
      prisma.serviceableArea.delete.mockResolvedValue(mockDelhi);

      const result = await service.deleteArea('area-delhi-1');
      expect(result.deleted).toBe(true);
      expect(prisma.serviceableArea.delete).toHaveBeenCalledWith({
        where: { id: 'area-delhi-1' },
      });
    });
  });
});
