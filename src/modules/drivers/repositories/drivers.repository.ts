import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';
import { DriverQueryDto } from '../dto/driver-query.dto';

@Injectable()
export class DriversRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findByUserId(userId: string) {
    return this.prisma.driver.findUnique({
      where: { userId },
      include: { user: true, vehicle: true, documents: true },
    });
  }

  async findById(id: string) {
    return this.prisma.driver.findUnique({
      where: { id },
      include: { user: true, vehicle: true, documents: true },
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
    const limit = query.limit || 10;
    const skip = (page - 1) * limit;

    const where: any = {};
    if (query.status) where.status = query.status;
    if (query.kycStatus) where.kycStatus = query.kycStatus;
    if (query.search) {
      where.user = {
        OR: [
          { name: { contains: query.search, mode: 'insensitive' } },
          { email: { contains: query.search, mode: 'insensitive' } },
        ],
      };
    }

    const [items, total] = await Promise.all([
      this.prisma.driver.findMany({
        where,
        skip,
        take: limit,
        include: { user: true },
      }),
      this.prisma.driver.count({ where }),
    ]);

    return {
      items,
      total,
      page,
      limit,
      totalPages: Math.ceil(total / limit),
    };
  }
}
