import { Injectable, Logger } from '@nestjs/common';
import { VehiclesRepository } from '../repositories/vehicles.repository';
import { CreateVehicleTypeDto } from '../dto/create-vehicle-type.dto';
import { RegisterVehicleDto } from '../dto/register-vehicle.dto';
import { UpdateVehicleDto } from '../dto/update-vehicle.dto';

@Injectable()
export class VehiclesService {
  private readonly logger = new Logger(VehiclesService.name);

  constructor(private readonly vehiclesRepo: VehiclesRepository) {}

  async createVehicleType(dto: CreateVehicleTypeDto) {
    return this.vehiclesRepo.createType(dto);
  }

  async getVehicleTypes() {
    return this.vehiclesRepo.findTypes();
  }

  async registerVehicle(driverId: string, dto: RegisterVehicleDto) {
    return this.vehiclesRepo.createVehicle(driverId, dto);
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
}
