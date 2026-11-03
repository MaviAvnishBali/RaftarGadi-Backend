import { Injectable, Logger, OnModuleInit, HttpStatus } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';
import { CreateServiceableAreaDto } from '../dto/create-serviceable-area.dto';
import { UpdateServiceableAreaDto } from '../dto/update-serviceable-area.dto';
import { AppException } from '../../../common/exceptions/app.exception';
import { ServiceableArea } from '@prisma/client';

export interface ServingAreaMatch {
  area: ServiceableArea;
  distanceKm: number;
}

export interface ServiceabilityCheckResult {
  isServiceable: boolean;
  latitude: number;
  longitude: number;
  matchedArea: ServiceableArea | null;
  distanceKm: number | null;
  message: string;
}

@Injectable()
export class ServiceableAreasService implements OnModuleInit {
  private readonly logger = new Logger(ServiceableAreasService.name);

  constructor(private readonly prisma: PrismaService) {}

  async onModuleInit(): Promise<void> {
    await this.seedDefaultAreasIfEmpty();
  }

  /**
   * Calculates the great-circle distance between two geographic coordinates using the Haversine formula.
   */
  calculateHaversineDistanceKm(
    lat1: number,
    lon1: number,
    lat2: number,
    lon2: number,
  ): number {
    const R = 6371; // Earth's mean radius in km
    const dLat = ((lat2 - lat1) * Math.PI) / 180;
    const dLon = ((lon2 - lon1) * Math.PI) / 180;
    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos((lat1 * Math.PI) / 180) *
        Math.cos((lat2 * Math.PI) / 180) *
        Math.sin(dLon / 2) *
        Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return Math.round(R * c * 100) / 100;
  }

  /**
   * Seeds default operational areas if no areas exist in the database.
   */
  async seedDefaultAreasIfEmpty(): Promise<void> {
    try {
      const count = await this.prisma.serviceableArea.count();
      if (count === 0) {
        this.logger.log('Seeding initial operational serviceable areas for Raftar Gaddi...');
        const initialAreas = [
          {
            name: 'New Delhi',
            state: 'Delhi NCR',
            centerLat: 28.6139,
            centerLng: 77.2090,
            radiusKm: 35.0,
            isActive: true,
          },
          {
            name: 'Noida',
            state: 'Uttar Pradesh',
            centerLat: 28.5355,
            centerLng: 77.3910,
            radiusKm: 25.0,
            isActive: true,
          },
          {
            name: 'Gurugram',
            state: 'Haryana',
            centerLat: 28.4595,
            centerLng: 77.0266,
            radiusKm: 30.0,
            isActive: true,
          },
          {
            name: 'Ghaziabad',
            state: 'Uttar Pradesh',
            centerLat: 28.6692,
            centerLng: 77.4538,
            radiusKm: 25.0,
            isActive: true,
          },
          {
            name: 'Faridabad',
            state: 'Haryana',
            centerLat: 28.4089,
            centerLng: 77.3178,
            radiusKm: 25.0,
            isActive: true,
          },
          {
            name: 'Mumbai',
            state: 'Maharashtra',
            centerLat: 19.0760,
            centerLng: 72.8777,
            radiusKm: 40.0,
            isActive: true,
          },
          {
            name: 'Bengaluru',
            state: 'Karnataka',
            centerLat: 12.9716,
            centerLng: 77.5946,
            radiusKm: 35.0,
            isActive: true,
          },
        ];

        for (const area of initialAreas) {
          await this.prisma.serviceableArea.create({ data: area });
        }
        this.logger.log(`Successfully seeded ${initialAreas.length} initial operational areas.`);
      }
    } catch (err: any) {
      this.logger.warn(`Could not seed serviceable areas automatically: ${err?.message}`);
    }
  }

  /**
   * Resolves the primary operational jurisdiction for a geographic location.
   * Prioritizes the nearest operational center (centroid) and strictly enforces
   * disabled area restrictions so larger overlapping zones (e.g. New Delhi)
   * cannot override an explicitly disabled satellite municipality (e.g. Gurugram).
   */
  async resolveArea(
    lat: number,
    lng: number,
    address?: string,
  ): Promise<{
    isServiceable: boolean;
    area: ServiceableArea | null;
    distanceKm: number | null;
    isExplicitlyDisabled: boolean;
    message: string;
  }> {
    if (isNaN(lat) || isNaN(lng) || lat < -90 || lat > 90 || lng < -180 || lng > 180) {
      return {
        isServiceable: false,
        area: null,
        distanceKm: null,
        isExplicitlyDisabled: false,
        message: 'Invalid coordinates provided.',
      };
    }

    const allAreas = await this.prisma.serviceableArea.findMany();
    if (allAreas.length === 0) {
      return {
        isServiceable: false,
        area: null,
        distanceKm: null,
        isExplicitlyDisabled: false,
        message: 'No operational areas configured.',
      };
    }

    const normalizedAddress = (address || '').toLowerCase().trim();

    // Calculate distance to all areas and check text heuristics
    const calculated = allAreas.map((area) => {
      const distanceKm = this.calculateHaversineDistanceKm(
        lat,
        lng,
        area.centerLat,
        area.centerLng,
      );
      const isWithinRadius = distanceKm <= area.radiusKm;
      const areaNameLower = area.name.toLowerCase();

      let isAddressMatch = false;
      if (normalizedAddress.length > 0) {
        if (normalizedAddress.includes(areaNameLower)) {
          isAddressMatch = true;
        } else if (
          areaNameLower.includes('gurugram') &&
          (normalizedAddress.includes('gurgaon') || normalizedAddress.includes('gurugram'))
        ) {
          isAddressMatch = true;
        } else if (areaNameLower.includes('delhi') && normalizedAddress.includes('delhi')) {
          isAddressMatch = true;
        } else if (
          areaNameLower.includes('bengaluru') &&
          (normalizedAddress.includes('bangalore') || normalizedAddress.includes('bengaluru'))
        ) {
          isAddressMatch = true;
        } else if (
          areaNameLower.includes('mumbai') &&
          (normalizedAddress.includes('mumbai') || normalizedAddress.includes('bombay'))
        ) {
          isAddressMatch = true;
        }
      }

      return {
        area,
        distanceKm,
        isWithinRadius,
        isAddressMatch,
      };
    });

    // 1. If address explicitly matches a disabled area and coordinates are within or proximate to it
    const disabledAddressMatch = calculated.find(
      (c) => c.isAddressMatch && !c.area.isActive,
    );
    if (disabledAddressMatch) {
      return {
        isServiceable: false,
        area: disabledAddressMatch.area,
        distanceKm: disabledAddressMatch.distanceKm,
        isExplicitlyDisabled: true,
        message: `Service is currently disabled in ${disabledAddressMatch.area.name} by administrator.`,
      };
    }

    // 2. Filter containing areas (within geographic radius)
    const containing = calculated.filter((c) => c.isWithinRadius);

    if (containing.length === 0) {
      return {
        isServiceable: false,
        area: null,
        distanceKm: null,
        isExplicitlyDisabled: false,
        message: 'Service is not yet available in your area. We are expanding soon!',
      };
    }

    // Sort by distance ascending: the closest defined center represents the primary operational authority
    containing.sort((a, b) => a.distanceKm - b.distanceKm);
    const closest = containing[0];

    // Check if the closest containing operational area is disabled
    if (!closest.area.isActive) {
      return {
        isServiceable: false,
        area: closest.area,
        distanceKm: closest.distanceKm,
        isExplicitlyDisabled: true,
        message: `Service is currently disabled in ${closest.area.name} by administrator.`,
      };
    }

    // If closest is active, check if any disabled area also covers this location and is matched by address
    const anyDisabledMatch = containing.find((c) => !c.area.isActive && c.isAddressMatch);
    if (anyDisabledMatch) {
      return {
        isServiceable: false,
        area: anyDisabledMatch.area,
        distanceKm: anyDisabledMatch.distanceKm,
        isExplicitlyDisabled: true,
        message: `Service is currently disabled in ${anyDisabledMatch.area.name} by administrator.`,
      };
    }

    // Closest area is active and authoritative
    return {
      isServiceable: true,
      area: closest.area,
      distanceKm: closest.distanceKm,
      isExplicitlyDisabled: false,
      message: `Location is within serviceable zone: ${closest.area.name}, ${closest.area.state} (${closest.distanceKm} km from center, radius ${closest.area.radiusKm} km)`,
    };
  }

  /**
   * Find an active operational area covering the given coordinates.
   */
  async findServingArea(
    lat: number,
    lng: number,
    address?: string,
  ): Promise<ServingAreaMatch | null> {
    const res = await this.resolveArea(lat, lng, address);
    if (res.isServiceable && res.area && res.distanceKm !== null) {
      return { area: res.area, distanceKm: res.distanceKm };
    }
    return null;
  }

  /**
   * Validates whether a location is serviceable. Throws an AppException if not serviceable.
   */
  async validateServiceability(
    lat: number,
    lng: number,
    address?: string,
    pointType: 'pickup' | 'drop' = 'pickup',
  ): Promise<ServiceableArea> {
    const res = await this.resolveArea(lat, lng, address);
    const label = pointType === 'pickup' ? 'Pickup' : 'Drop';

    if (!res.isServiceable) {
      if (res.isExplicitlyDisabled && res.area) {
        throw new AppException(
          'AREA_NOT_SERVICEABLE',
          `Service is currently disabled in ${res.area.name} by administrator. ${label} location cannot be booked.`,
          HttpStatus.BAD_REQUEST,
        );
      }
      const locationLabel = address ? ` at "${address}"` : '';
      throw new AppException(
        'AREA_NOT_SERVICEABLE',
        `Service is not yet available in your area for ${pointType} location${locationLabel}. We are expanding soon!`,
        HttpStatus.BAD_REQUEST,
      );
    }

    return res.area!;
  }

  /**
   * Public check endpoint handler for mobile apps to inspect coordinates.
   */
  async checkLocationServiceability(
    lat: number,
    lng: number,
    address?: string,
  ): Promise<ServiceabilityCheckResult> {
    const res = await this.resolveArea(lat, lng, address);
    return {
      isServiceable: res.isServiceable,
      latitude: lat,
      longitude: lng,
      matchedArea: res.area,
      distanceKm: res.distanceKm,
      message: res.message,
    };
  }

  /**
   * Admin: List all operational areas.
   */
  async findAll(onlyActive?: boolean): Promise<ServiceableArea[]> {
    return this.prisma.serviceableArea.findMany({
      where: onlyActive ? { isActive: true } : undefined,
      orderBy: [{ state: 'asc' }, { name: 'asc' }],
    });
  }

  /**
   * Admin: Get single operational area by ID.
   */
  async findById(id: string): Promise<ServiceableArea> {
    const area = await this.prisma.serviceableArea.findUnique({
      where: { id },
    });
    if (!area) {
      throw new AppException('NOT_FOUND', `Serviceable area ${id} not found`, HttpStatus.NOT_FOUND);
    }
    return area;
  }

  /**
   * Admin: Create a new operational area.
   */
  async createArea(dto: CreateServiceableAreaDto): Promise<ServiceableArea> {
    return this.prisma.serviceableArea.create({
      data: {
        name: dto.name.trim(),
        state: dto.state.trim(),
        centerLat: dto.centerLat,
        centerLng: dto.centerLng,
        radiusKm: dto.radiusKm,
        isActive: dto.isActive !== undefined ? dto.isActive : true,
      },
    });
  }

  /**
   * Admin: Update an existing operational area.
   */
  async updateArea(id: string, dto: UpdateServiceableAreaDto): Promise<ServiceableArea> {
    await this.findById(id);

    return this.prisma.serviceableArea.update({
      where: { id },
      data: {
        ...(dto.name !== undefined ? { name: dto.name.trim() } : {}),
        ...(dto.state !== undefined ? { state: dto.state.trim() } : {}),
        ...(dto.centerLat !== undefined ? { centerLat: dto.centerLat } : {}),
        ...(dto.centerLng !== undefined ? { centerLng: dto.centerLng } : {}),
        ...(dto.radiusKm !== undefined ? { radiusKm: dto.radiusKm } : {}),
        ...(dto.isActive !== undefined ? { isActive: dto.isActive } : {}),
      },
    });
  }

  /**
   * Admin: Toggle active status of an area.
   */
  async toggleActive(id: string, isActive: boolean): Promise<ServiceableArea> {
    await this.findById(id);
    return this.prisma.serviceableArea.update({
      where: { id },
      data: { isActive },
    });
  }

  /**
   * Admin: Delete an operational area.
   */
  async deleteArea(id: string): Promise<{ deleted: boolean; id: string }> {
    await this.findById(id);
    await this.prisma.serviceableArea.delete({
      where: { id },
    });
    return { deleted: true, id };
  }
}
