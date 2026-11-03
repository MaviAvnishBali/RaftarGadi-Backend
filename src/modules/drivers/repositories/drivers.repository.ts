import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';
import { DriverQueryDto } from '../dto/driver-query.dto';

@Injectable()
export class DriversRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findByUserId(userId: string) {
    return this.prisma.driver.findUnique({
      where: { userId },
      include: {
        user: true,
        vehicle: {
          include: {
            vehicleType: true,
          },
        },
        wallet: true,
        documents: true,
      },
    });
  }

  async findById(id: string) {
    return this.prisma.driver.findUnique({
      where: { id },
      include: {
        user: true,
        vehicle: {
          include: {
            vehicleType: true,
          },
        },
        wallet: true,
        documents: true,
      },
    });
  }

  async create(userId: string, dto: any) {
    return this.prisma.driver.create({
      data: {
        userId,
        licenseNumber: dto.licenseNumber,
      },
    });
  }

  async updateByUserId(userId: string, data: any) {
    return this.prisma.driver.update({
      where: { userId },
      data,
    });
  }

  async update(id: string, data: any) {
    return this.prisma.driver.update({
      where: { id },
      data,
    });
  }

  async createDocument(driverId: string, dto: any) {
    return this.prisma.driverDocument.create({
      data: {
        driverId,
        documentType: dto.documentType,
        documentUrl: dto.documentUrl,
      },
    });
  }

  async findAll(query: DriverQueryDto) {
    const page = query.page || 1;
    const limit = query.limit || 20;
    const skip = (page - 1) * limit;

    const where: any = {};
    if (query.status && query.status !== 'ALL') {
      const s = query.status.toUpperCase();
      if (s === 'PENDING_KYC' || s === 'PENDING') {
        where.kycStatus = { in: ['PENDING', 'SUBMITTED'] };
      } else if (s === 'ACTIVE') {
        where.status = { in: ['ONLINE', 'OFFLINE', 'BUSY'] };
        where.kycStatus = 'APPROVED';
      } else if (s === 'SUSPENDED') {
        where.status = 'SUSPENDED';
      } else {
        where.status = query.status;
      }
    }
    if (query.kycStatus) where.kycStatus = query.kycStatus;
    if (query.search) {
      where.OR = [
        { user: { name: { contains: query.search, mode: 'insensitive' } } },
        { user: { phone: { contains: query.search } } },
        { user: { email: { contains: query.search, mode: 'insensitive' } } },
        { licenseNumber: { contains: query.search, mode: 'insensitive' } },
      ];
    }

    try {
      const [items, total] = await Promise.all([
        this.prisma.driver.findMany({
          where,
          skip,
          take: limit,
          include: {
            user: true,
            vehicle: { include: { vehicleType: true } },
            documents: true,
          },
          orderBy: { createdAt: 'desc' },
        }),
        this.prisma.driver.count({ where }),
      ]);

      return {
        items,
        data: items,
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      };
    } catch (_) {
      return {
        items: [],
        data: [],
        total: 0,
        page,
        limit,
        totalPages: 0,
      };
    }
  }

  async getDashboardData(driverId: string, vehicleTypeId?: string, isAvailable?: boolean) {
    const startOfDay = new Date();
    startOfDay.setHours(0, 0, 0, 0);

    const [todayBookings, activeBooking, incomingBooking] = await Promise.all([
      this.prisma.booking.findMany({
        where: {
          driverId,
          status: 'TRIP_COMPLETED',
          tripCompletedAt: { gte: startOfDay },
        },
      }),
      this.prisma.booking.findFirst({
        where: {
          driverId,
          status: { in: ['DRIVER_ASSIGNED', 'DRIVER_ARRIVING', 'DRIVER_ARRIVED', 'TRIP_STARTED'] },
        },
        include: {
          customer: { include: { user: true } },
          vehicleType: true,
        },
        orderBy: { updatedAt: 'desc' },
      }),
      isAvailable && vehicleTypeId
        ? this.prisma.booking.findFirst({
            where: {
              status: 'REQUESTED',
              vehicleTypeId,
              driverId: null,
            },
            include: {
              customer: { include: { user: true } },
              vehicleType: true,
            },
            orderBy: { createdAt: 'desc' },
          })
        : null,
    ]);

    const earnings = todayBookings.reduce((sum, b) => sum + (b.finalFare || 0), 0);

    return {
      todayEarnings: earnings,
      todayTrips: todayBookings.length,
      activeBooking: activeBooking || incomingBooking,
    };
  }
}
