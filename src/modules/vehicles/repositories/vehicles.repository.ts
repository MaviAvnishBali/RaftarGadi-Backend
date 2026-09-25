import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';

@Injectable()
export class VehiclesRepository {
  constructor(private readonly prisma: PrismaService) {}

  async createType(dto: any) {
    return this.prisma.vehicleType.create({ data: dto });
  }

  async findTypes() {
    return this.prisma.vehicleType.findMany({
      where: { isActive: true },
      orderBy: { sortOrder: 'asc' },
    });
  }

  async createVehicle(driverId: string, dto: any) {
    return this.prisma.vehicle.create({
      data: {
        driverId,
        vehicleTypeId: dto.vehicleTypeId,
        registrationNumber: dto.registrationNumber,
        model: dto.model,
        color: dto.color,
        manufactureYear: dto.manufactureYear,
      },
    });
  }

  async updateVehicle(id: string, data: any) {
    return this.prisma.vehicle.update({
      where: { id },
      data,
    });
  }

  async findByDriverId(driverId: string) {
    return this.prisma.vehicle.findUnique({
      where: { driverId },
      include: { vehicleType: true },
    });
  }

  async findById(id: string) {
    return this.prisma.vehicle.findUnique({
      where: { id },
      include: { vehicleType: true, driver: true },
    });
  }
}
