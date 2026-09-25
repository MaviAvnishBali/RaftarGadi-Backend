import { DriverStatus } from '@prisma/client';
import { Injectable, Logger } from '@nestjs/common';
import { DriversRepository } from '../repositories/drivers.repository';
import { RegisterDriverDto } from '../dto/register-driver.dto';
import { UpdateDriverDto } from '../dto/update-driver.dto';
import { UploadDocumentDto } from '../dto/upload-document.dto';
import { DriverQueryDto } from '../dto/driver-query.dto';
import { AppException } from '../../../common/exceptions/app.exception';

@Injectable()
export class DriversService {
  private readonly logger = new Logger(DriversService.name);

  constructor(private readonly driversRepo: DriversRepository) {}

  async getProfile(userId: string) {
    const driver = await this.driversRepo.findByUserId(userId);
    if (!driver) throw new AppException('ERROR', 'Driver profile not found', 404);
    return driver;
  }

  async updateProfile(userId: string, dto: UpdateDriverDto) {
    return this.driversRepo.updateByUserId(userId, dto);
  }

  async registerDriver(userId: string, dto: RegisterDriverDto) {
    const existing = await this.driversRepo.findByUserId(userId);
    if (existing) throw new AppException('ERROR', 'Driver already registered', 400);
    return this.driversRepo.create(userId, dto);
  }

  async goOnline(driverId: string) {
    await this.driversRepo.update(driverId, { status: DriverStatus.ONLINE, isAvailable: true });
  }

  async goOffline(driverId: string) {
    await this.driversRepo.update(driverId, { status: DriverStatus.OFFLINE, isAvailable: false });
  }

  async updateStatus(driverId: string, status: DriverStatus) {
    return this.driversRepo.update(driverId, { status });
  }

  async uploadDocument(driverId: string, dto: UploadDocumentDto) {
    return this.driversRepo.createDocument(driverId, dto);
  }

  async approveDriver(driverId: string) {
    return this.driversRepo.update(driverId, { kycStatus: 'APPROVED' }); // assuming APPROVED in KycStatus
  }

  async suspendDriver(driverId: string, reason: string) {
    return this.driversRepo.update(driverId, {
      status: DriverStatus.SUSPENDED,
      suspendReason: reason,
    });
  }

  async findAll(query: DriverQueryDto) {
    return this.driversRepo.findAll(query);
  }

  async findById(id: string) {
    return this.driversRepo.findById(id);
  }

  async findByUserId(userId: string) {
    return this.driversRepo.findByUserId(userId);
  }

  async updateRating(driverId: string, newRating: number) {
    await this.driversRepo.update(driverId, { rating: newRating });
  }
}
