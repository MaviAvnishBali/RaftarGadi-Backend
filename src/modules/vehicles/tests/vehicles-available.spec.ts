import { Test, TestingModule } from '@nestjs/testing';
import { VehiclesService } from '../services/vehicles.service';
import { VehiclesRepository } from '../repositories/vehicles.repository';
import { PrismaService } from '../../../database/prisma.service';
import { LocationsService } from '../../locations/services/locations.service';
import { AppException } from '../../../common/exceptions/app.exception';

describe('VehiclesService - findAvailableVehiclesNearby', () => {
  let service: VehiclesService;
  let prisma: any;
  let locationsService: any;

  const mockVehicleTypes = [
    {
      id: 'type-bike',
      name: '2-Wheeler',
      description: 'Quick parcel delivery',
      maxWeightKg: 30,
      dimensions: '40x40x40 cm',
      iconUrl: null,
      isActive: true,
      sortOrder: 0,
    },
    {
      id: 'type-ace',
      name: 'Tata Ace',
      description: 'Mini truck for commercial goods',
      maxWeightKg: 850,
      dimensions: '7x4x5 ft',
      iconUrl: null,
      isActive: true,
      sortOrder: 1,
    },
  ];

  beforeEach(async () => {
    prisma = {
      vehicleType: {
        findMany: jest.fn().mockResolvedValue(mockVehicleTypes),
      },
      driver: {
        findMany: jest.fn(),
      },
    };

    locationsService = {
      findNearbyDrivers: jest.fn(),
      getDriverLocation: jest.fn(),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        VehiclesService,
        { provide: VehiclesRepository, useValue: {} },
        { provide: PrismaService, useValue: prisma },
        { provide: LocationsService, useValue: locationsService },
      ],
    }).compile();

    service = module.get<VehiclesService>(VehiclesService);
  });

  it('throws an AppException for invalid coordinates', async () => {
    await expect(service.findAvailableVehiclesNearby(95, 77)).rejects.toThrow(AppException);
    await expect(service.findAvailableVehiclesNearby(28, 200)).rejects.toThrow(AppException);
    await expect(service.findAvailableVehiclesNearby(NaN, 77)).rejects.toThrow(AppException);
  });

  it('returns all vehicle types with isAvailable=false when no drivers are nearby within 25 km', async () => {
    locationsService.findNearbyDrivers.mockResolvedValue([]);

    const result = await service.findAvailableVehiclesNearby(28.6139, 77.2090);

    expect(result.totalAvailableDrivers).toBe(0);
    expect(result.searchRadiusKm).toBe(50);
    expect(result.vehicleTypes).toHaveLength(2);
    expect(result.vehicleTypes[0].isAvailable).toBe(false);
    expect(result.vehicleTypes[0].availableCount).toBe(0);
    expect(result.vehicleTypes[0].nearestDistanceKm).toBeNull();
    expect(result.vehicleTypes[0].estimatedEtaMinutes).toBeNull();
  });

  it('discovers and aggregates available vehicles within 10 km', async () => {
    // 2 drivers within 10 km
    locationsService.findNearbyDrivers.mockResolvedValue([
      { driverId: 'driver-1', distanceKm: 2.5 },
      { driverId: 'driver-2', distanceKm: 4.8 },
    ]);

    locationsService.getDriverLocation.mockImplementation(async (id: string) => {
      if (id === 'driver-1') return { latitude: 28.62, longitude: 77.21, heading: 45 };
      return { latitude: 28.64, longitude: 77.23, heading: 90 };
    });

    prisma.driver.findMany.mockResolvedValue([
      {
        id: 'driver-1',
        status: 'ONLINE',
        isAvailable: true,
        kycStatus: 'VERIFIED',
        vehicle: {
          id: 'v-1',
          vehicleTypeId: 'type-bike',
          vehicleType: mockVehicleTypes[0],
          isActive: true,
        },
      },
      {
        id: 'driver-2',
        status: 'ONLINE',
        isAvailable: true,
        kycStatus: 'VERIFIED',
        vehicle: {
          id: 'v-2',
          vehicleTypeId: 'type-ace',
          vehicleType: mockVehicleTypes[1],
          isActive: true,
        },
      },
    ]);

    const result = await service.findAvailableVehiclesNearby(28.6139, 77.2090);

    expect(result.totalAvailableDrivers).toBe(2);
    expect(result.searchRadiusKm).toBe(10);
    expect(result.nearbyVehicles).toHaveLength(2);

    const bikeType = result.vehicleTypes.find((vt: any) => vt.id === 'type-bike')!;
    expect(bikeType.isAvailable).toBe(true);
    expect(bikeType.availableCount).toBe(1);
    expect(bikeType.nearestDistanceKm).toBe(2.5);
    expect(bikeType.matchedRadiusKm).toBe(10);
    expect(bikeType.estimatedEtaMinutes).toBeGreaterThanOrEqual(3);

    const aceType = result.vehicleTypes.find((vt: any) => vt.id === 'type-ace')!;
    expect(aceType.isAvailable).toBe(true);
    expect(aceType.availableCount).toBe(1);
    expect(aceType.nearestDistanceKm).toBe(4.8);
    expect(aceType.matchedRadiusKm).toBe(10);
  });

  it('correctly reports 15 km matched radius when vehicles are only available beyond 10 km', async () => {
    locationsService.findNearbyDrivers.mockResolvedValue([
      { driverId: 'driver-far', distanceKm: 12.3 },
    ]);

    locationsService.getDriverLocation.mockResolvedValue({
      latitude: 28.70,
      longitude: 77.30,
      heading: 180,
    });

    prisma.driver.findMany.mockResolvedValue([
      {
        id: 'driver-far',
        status: 'ONLINE',
        isAvailable: true,
        kycStatus: 'VERIFIED',
        vehicle: {
          id: 'v-far',
          vehicleTypeId: 'type-ace',
          vehicleType: mockVehicleTypes[1],
          isActive: true,
        },
      },
    ]);

    const result = await service.findAvailableVehiclesNearby(28.6139, 77.2090);

    expect(result.totalAvailableDrivers).toBe(1);
    expect(result.searchRadiusKm).toBe(25);

    const aceType = result.vehicleTypes.find((vt: any) => vt.id === 'type-ace')!;
    expect(aceType.isAvailable).toBe(true);
    expect(aceType.nearestDistanceKm).toBe(12.3);
    expect(aceType.matchedRadiusKm).toBe(25);
  });
});
