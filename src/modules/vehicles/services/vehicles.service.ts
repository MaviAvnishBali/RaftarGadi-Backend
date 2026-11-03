import { Injectable, Logger, Optional } from '@nestjs/common';
import { VehiclesRepository } from '../repositories/vehicles.repository';
import { CreateVehicleTypeDto } from '../dto/create-vehicle-type.dto';
import { RegisterVehicleDto } from '../dto/register-vehicle.dto';
import { UpdateVehicleDto } from '../dto/update-vehicle.dto';
import { PrismaService } from '../../../database/prisma.service';
import { LocationsService } from '../../locations/services/locations.service';
import { ServiceableAreasService } from '../../serviceable-areas/services/serviceable-areas.service';
import { AppException } from '../../../common/exceptions/app.exception';

@Injectable()
export class VehiclesService {
  private readonly logger = new Logger(VehiclesService.name);

  constructor(
    private readonly vehiclesRepo: VehiclesRepository,
    private readonly prisma: PrismaService,
    private readonly locationsService: LocationsService,
    @Optional() private readonly serviceableAreasService?: ServiceableAreasService,
  ) {}

  async createVehicleType(dto: CreateVehicleTypeDto) {
    const { baseFare, perKmCharge, perMinCharge, minimumFare, ...typeData } = dto;
    if (typeData.sortOrder === undefined) {
      const count = await this.prisma.vehicleType.count();
      typeData.sortOrder = count;
    }
    const vehicleType = await this.vehiclesRepo.createType(typeData);

    const base = baseFare ?? 100;
    const perKm = perKmCharge ?? 15;
    const perMin = perMinCharge ?? 2;
    const minFare = minimumFare ?? base;

    await this.prisma.pricingRule.create({
      data: {
        vehicleTypeId: vehicleType.id,
        city: 'default',
        baseFare: base,
        perKmCharge: perKm,
        perMinCharge: perMin,
        minimumFare: minFare,
        platformFeePercent: 10.0,
        taxPercent: 5.0,
        surgeMultiplier: 1.0,
        effectiveFrom: new Date(),
      },
    });

    return vehicleType;
  }

  async updateVehicleType(id: string, dto: any) {
    return this.prisma.vehicleType.update({
      where: { id },
      data: dto,
    });
  }

  async getVehicleTypes() {
    return this.vehiclesRepo.findTypes();
  }

  async registerVehicle(userId: string, dto: RegisterVehicleDto) {
    this.logger.log(`Registering vehicle for user: ${userId}`);

    // Resolve or create Driver record for this user
    let driver = await this.prisma.driver.findUnique({ where: { userId } });
    if (!driver) {
      driver = await this.prisma.driver.create({
        data: { userId },
      });
    }

    // Resolve vehicleTypeId to a valid database UUID
    let targetTypeId = dto.vehicleTypeId;
    const isUuid = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(dto.vehicleTypeId);
    
    if (!isUuid) {
      // Find matching type by name keyword (e.g. 2-wheeler, bike, tata ace)
      const matchingType = await this.prisma.vehicleType.findFirst({
        where: {
          OR: [
            { name: { contains: '2-Wheeler', mode: 'insensitive' } },
            { name: { contains: dto.vehicleTypeId, mode: 'insensitive' } },
          ],
        },
      });
      if (matchingType) {
        targetTypeId = matchingType.id;
      } else {
        const firstType = await this.prisma.vehicleType.findFirst({ orderBy: { sortOrder: 'asc' } });
        if (firstType) targetTypeId = firstType.id;
      }
    }

    const payload = {
      ...dto,
      vehicleTypeId: targetTypeId,
    };

    // If driver already has a vehicle registered, update it
    const existingVehicle = await this.vehiclesRepo.findByDriverId(driver.id);
    if (existingVehicle) {
      return this.vehiclesRepo.updateVehicle(existingVehicle.id, {
        vehicleTypeId: targetTypeId,
        registrationNumber: dto.registrationNumber.toUpperCase().trim(),
        model: dto.model,
        bodyType: dto.bodyType,
        color: dto.color,
        manufactureYear: dto.manufactureYear,
      });
    }

    return this.vehiclesRepo.createVehicle(driver.id, payload);
  }

  async updateVehicle(vehicleId: string, dto: UpdateVehicleDto) {
    return this.vehiclesRepo.updateVehicle(vehicleId, dto);
  }

  async getDriverVehicle(driverId: string) {
    return this.vehiclesRepo.findByDriverId(driverId);
  }

  async findById(id: string) {
    return this.vehiclesRepo.findById(id);
  }

  /**
   * Discovers available vehicles in the given area using progressive Redis geospatial search
   * (10 km -> 15 km -> 25 km) based on current location or pickup location.
   */
  async findAvailableVehiclesNearby(lat: number, lng: number) {
    if (isNaN(lat) || isNaN(lng) || lat < -90 || lat > 90 || lng < -180 || lng > 180) {
      throw new AppException('INVALID_COORDINATES', 'Latitude and longitude coordinates are invalid', 400);
    }

    // 1. Fetch all active vehicle types from PostgreSQL database
    const allVehicleTypes = await this.prisma.vehicleType.findMany({
      where: { isActive: true },
      orderBy: { sortOrder: 'asc' },
    });

    // 2. Validate operational serviceability (e.g. if admin disabled the city/area)
    if (this.serviceableAreasService) {
      const areaCheck = await this.serviceableAreasService.resolveArea(lat, lng);
      if (!areaCheck.isServiceable) {
        return {
          searchLocation: { latitude: lat, longitude: lng },
          searchRadiusKm: 50,
          totalAvailableDrivers: 0,
          isServiceable: false,
          message: areaCheck.message,
          vehicleTypes: allVehicleTypes.map((vt) => ({
            id: vt.id,
            name: vt.name,
            description: vt.description,
            maxWeightKg: vt.maxWeightKg,
            dimensions: vt.dimensions,
            iconUrl: vt.iconUrl,
            isAvailable: false,
            availableCount: 0,
            nearestDistanceKm: null,
            estimatedEtaMinutes: null,
            matchedRadiusKm: null,
          })),
          nearbyVehicles: [],
        };
      }
    }

    // 3. Search maximum radius (50 km) using Redis GEOSEARCH with GEORADIUS fallback
    const nearbyCandidates = await this.locationsService.findNearbyDrivers(lat, lng, 50, 200);

    if (nearbyCandidates.length === 0) {
      return {
        searchLocation: { latitude: lat, longitude: lng },
        searchRadiusKm: 50,
        totalAvailableDrivers: 0,
        vehicleTypes: allVehicleTypes.map((vt) => ({
          id: vt.id,
          name: vt.name,
          description: vt.description,
          maxWeightKg: vt.maxWeightKg,
          dimensions: vt.dimensions,
          iconUrl: vt.iconUrl,
          isAvailable: false,
          availableCount: 0,
          nearestDistanceKm: null,
          estimatedEtaMinutes: null,
          matchedRadiusKm: null,
        })),
        nearbyVehicles: [],
      };
    }

    const distanceMap = new Map<string, number>();
    for (const item of nearbyCandidates) {
      distanceMap.set(item.driverId, item.distanceKm);
    }

    const candidateIds = nearbyCandidates.map((c) => c.driverId);

    // 3. Query PostgreSQL for eligible drivers:
    // ONLINE, isAvailable, not rejected kyc, active vehicle, no active assigned trips
    const eligibleDrivers = (await this.prisma.driver.findMany({
      where: {
        id: { in: candidateIds },
        status: 'ONLINE',
        isAvailable: true,
        kycStatus: { not: 'REJECTED' },
        vehicle: {
          isActive: true,
        },
        bookings: {
          none: {
            status: { in: ['DRIVER_ASSIGNED', 'DRIVER_ARRIVING', 'DRIVER_ARRIVED', 'TRIP_STARTED'] },
          },
        },
      },
      include: {
        vehicle: {
          include: {
            vehicleType: true,
          },
        },
      },
    })) as any[];

    // Determine primary searchRadiusKm (first bucket: 10, 25, or 50 km that matches)
    let primaryRadiusKm = 50;
    const has10km = eligibleDrivers.some((d) => (distanceMap.get(d.id) ?? 999) <= 10);
    const has25km = eligibleDrivers.some((d) => (distanceMap.get(d.id) ?? 999) <= 25);
    if (has10km) {
      primaryRadiusKm = 10;
    } else if (has25km) {
      primaryRadiusKm = 25;
    }

    // 4. Assemble nearbyVehicles with their coordinates and headings
    const nearbyVehiclesList = [];
    for (const d of eligibleDrivers) {
      if (!d.vehicle) continue;
      const dist = distanceMap.get(d.id) ?? 0;
      const loc = await this.locationsService.getDriverLocation(d.id);
      nearbyVehiclesList.push({
        driverId: d.id,
        vehicleId: d.vehicle.id,
        vehicleTypeId: d.vehicle.vehicleTypeId,
        vehicleTypeName: d.vehicle.vehicleType?.name ?? 'Vehicle',
        latitude: loc?.latitude ?? lat,
        longitude: loc?.longitude ?? lng,
        heading: loc?.heading ?? 0,
        distanceKm: Math.round(dist * 10) / 10,
        radiusBucketKm: dist <= 10 ? 10 : dist <= 25 ? 25 : 50,
      });
    }

    // 5. Aggregate metrics for each vehicle type
    const vehicleTypesResult = allVehicleTypes.map((vt) => {
      const matchingDrivers = eligibleDrivers.filter(
        (d) => d.vehicle && d.vehicle.vehicleTypeId === vt.id,
      );

      if (matchingDrivers.length === 0) {
        return {
          id: vt.id,
          name: vt.name,
          description: vt.description,
          maxWeightKg: vt.maxWeightKg,
          dimensions: vt.dimensions,
          iconUrl: vt.iconUrl,
          isAvailable: false,
          availableCount: 0,
          nearestDistanceKm: null,
          estimatedEtaMinutes: null,
          matchedRadiusKm: null,
        };
      }

      const distances = matchingDrivers.map((d) => distanceMap.get(d.id) ?? 999);
      const nearestDist = Math.min(...distances);
      const roundedDist = Math.round(nearestDist * 10) / 10;
      const matchedRadius = nearestDist <= 10 ? 10 : nearestDist <= 25 ? 25 : 50;
      const eta = Math.max(3, Math.round(nearestDist * 2.2 + 2));

      return {
        id: vt.id,
        name: vt.name,
        description: vt.description,
        maxWeightKg: vt.maxWeightKg,
        dimensions: vt.dimensions,
        iconUrl: vt.iconUrl,
        isAvailable: true,
        availableCount: matchingDrivers.length,
        nearestDistanceKm: roundedDist,
        estimatedEtaMinutes: eta,
        matchedRadiusKm: matchedRadius,
      };
    });

    return {
      searchLocation: { latitude: lat, longitude: lng },
      searchRadiusKm: primaryRadiusKm,
      totalAvailableDrivers: eligibleDrivers.length,
      vehicleTypes: vehicleTypesResult,
      nearbyVehicles: nearbyVehiclesList,
    };
  }
}
