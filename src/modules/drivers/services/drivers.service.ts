import { DriverStatus } from '@prisma/client';
import { Injectable, Logger } from '@nestjs/common';
import { DriversRepository } from '../repositories/drivers.repository';
import { RegisterDriverDto } from '../dto/register-driver.dto';
import { UpdateDriverDto } from '../dto/update-driver.dto';
import { UploadDocumentDto } from '../dto/upload-document.dto';
import { DriverQueryDto } from '../dto/driver-query.dto';
import { AppException } from '../../../common/exceptions/app.exception';
import { KycVerificationService } from './kyc-verification.service';
import { SubmitKycDto } from '../dto/submit-kyc.dto';
import { RedisService } from '../../../config/redis.service';

@Injectable()
export class DriversService {
  private readonly logger = new Logger(DriversService.name);

  constructor(
    private readonly driversRepo: DriversRepository,
    private readonly kycVerificationService: KycVerificationService,
    private readonly redisService: RedisService,
  ) {}

  async getProfile(userId: string) {
    const driver = await this.driversRepo.findByUserId(userId);
    if (!driver) throw new AppException('ERROR', 'Driver profile not found', 404);
    return driver;
  }

  async getDashboard(userId: string) {
    const driver = await this.driversRepo.findByUserId(userId);
    if (!driver) throw new AppException('ERROR', 'Driver profile not found', 404);

    const dash = await this.driversRepo.getDashboardData(
      driver.id,
      driver.vehicle?.vehicleTypeId,
      driver.isAvailable,
    );

    return {
      driver,
      today: {
        earnings: dash.todayEarnings,
        tripsCount: dash.todayTrips,
        onlineMinutes: driver.isAvailable ? 45 : 0,
      },
      wallet: driver.wallet || { balance: 0, totalEarned: 0 },
      activeBooking: dash.activeBooking,
    };
  }

  async updateProfile(userId: string, dto: UpdateDriverDto) {
    return this.driversRepo.updateByUserId(userId, dto);
  }

  async registerDriver(userId: string, dto: RegisterDriverDto) {
    const existing = await this.driversRepo.findByUserId(userId);
    if (existing) throw new AppException('ERROR', 'Driver already registered', 400);
    return this.driversRepo.create(userId, dto);
  }

  async goOnline(userIdOrDriverId: string) {
    const driver =
      (await this.driversRepo.findByUserId(userIdOrDriverId)) ||
      (await this.driversRepo.findById(userIdOrDriverId));
    if (!driver) throw new AppException('ERROR', 'Driver profile not found', 404);
    await this.driversRepo.update(driver.id, { status: DriverStatus.ONLINE, isAvailable: true });
    try {
      let lat: number | null = null;
      let lng: number | null = null;
      let heading = 0;
      let speed = 0;

      const loc = await this.redisService.client.get(`driver:location:${driver.id}`);
      if (loc) {
        try {
          const parsed = JSON.parse(loc);
          if (parsed.lat && parsed.lng) {
            lat = Number(parsed.lat);
            lng = Number(parsed.lng);
            heading = parsed.heading ?? 0;
            speed = parsed.speed ?? 0;
          }
        } catch (_) {}
      }

      if (lat === null || lng === null) {
        const lastLoc = await this.driversRepo.findLastLocation(driver.id);
        if (lastLoc) {
          lat = lastLoc.latitude;
          lng = lastLoc.longitude;
          heading = lastLoc.heading ?? 0;
          speed = lastLoc.speed ?? 0;
        }
      }

      if (lat !== null && lng !== null) {
        await this.redisService.client.geoadd('drivers:online', lng, lat, driver.id);
        await this.redisService.client.set(
          `driver:location:${driver.id}`,
          JSON.stringify({
            lat,
            lng,
            heading,
            speed,
            timestamp: Date.now(),
          }),
          'EX',
          86400,
        );
      }
    } catch (err) {
      this.logger.error(`Failed to restore driver ${driver.id} to Redis on goOnline: ${err}`);
    }
    return { success: true, status: DriverStatus.ONLINE, isAvailable: true };
  }

  async goOffline(userIdOrDriverId: string) {
    const driver =
      (await this.driversRepo.findByUserId(userIdOrDriverId)) ||
      (await this.driversRepo.findById(userIdOrDriverId));
    if (!driver) throw new AppException('ERROR', 'Driver profile not found', 404);
    await this.driversRepo.update(driver.id, { status: DriverStatus.OFFLINE, isAvailable: false });
    try {
      await this.redisService.client.zrem('drivers:online', driver.id);
      // Retain last known coordinates in driver:location:${driver.id} with 24hr TTL
      // so goOnline can immediately re-publish to geospatial index
    } catch (err) {
      this.logger.error(`Failed to remove driver ${driver.id} from Redis on goOffline: ${err}`);
    }
    return { success: true, status: DriverStatus.OFFLINE, isAvailable: false };
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

  async verifyAndSaveLicense(userId: string, licenseNumber: string) {
    const driver = await this.getProfile(userId);
    
    // Call 3rd-party validation mock
    const result = await this.kycVerificationService.verifyDrivingLicense(licenseNumber);
    
    if (result.isValid) {
      await this.driversRepo.update(driver.id, {
        licenseNumber,
        kycStatus: 'SUBMITTED', // Or whatever transition makes sense
      });
      
      return {
        success: true,
        message: 'Driving license verified successfully',
        details: result,
      };
    }
  }

  async submitKycDetails(userId: string, dto: SubmitKycDto) {
    const existing = await this.driversRepo.findByUserId(userId);
    const driverId = existing
      ? existing.id
      : (await this.driversRepo.create(userId, { licenseNumber: dto.licenseNumber })).id;

    const processed = await this.kycVerificationService.processKycSubmission(dto);

    const updatedDriver = await this.driversRepo.update(driverId, {
      licenseNumber: processed.licenseNumber,
      dob: processed.dob,
      licenseExpiry: processed.licenseExpiry,
      aadhaarNumber: processed.aadhaarNumber,
      maskedAadhaar: processed.maskedAadhaar,
      aadhaarName: processed.aadhaarName,
      kycStatus: 'SUBMITTED',
      kycSubmittedAt: processed.kycSubmittedAt,
      kycProviderReference: processed.kycProviderReference,
    });

    return {
      success: true,
      message: 'Driver identification and KYC details saved successfully',
      driver: {
        id: updatedDriver.id,
        licenseNumber: updatedDriver.licenseNumber,
        maskedAadhaar: updatedDriver.maskedAadhaar,
        aadhaarName: updatedDriver.aadhaarName,
        kycStatus: updatedDriver.kycStatus,
      },
    };
  }
}
