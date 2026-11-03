import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';
import { UpdateCustomerDto } from '../dto/update-customer.dto';
import { PaginationDto } from '../../../common/dto/pagination.dto';

@Injectable()
export class CustomersRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findByUserId(userId: string) {
    return this.prisma.customer.findUnique({
      where: { userId },
      include: { user: true },
    });
  }

  async findUserById(userId: string) {
    return this.prisma.user.findUnique({
      where: { id: userId },
    });
  }

  async updateUser(userId: string, data: { name?: string; email?: string }) {
    return this.prisma.user.update({
      where: { id: userId },
      data,
    });
  }

  async create(userId: string, dto: UpdateCustomerDto) {
    return this.prisma.customer.create({
      data: {
        userId,
        address: dto.address,
        savedLat: dto.savedLat,
        savedLng: dto.savedLng,
      },
      include: { user: true },
    });
  }

  async update(userId: string, dto: UpdateCustomerDto) {
    const data: any = {};
    if (dto.address !== undefined) data.address = dto.address;
    if (dto.savedLat !== undefined) data.savedLat = dto.savedLat;
    if (dto.savedLng !== undefined) data.savedLng = dto.savedLng;

    return this.prisma.customer.update({
      where: { userId },
      data,
      include: { user: true },
    });
  }

  async findAll(query: any) {
    const page = query.page || 1;
    const limit = query.limit || 20;
    const skip = (page - 1) * limit;

    const where: any = {};
    if (query.search) {
      where.user = {
        OR: [
          { name: { contains: query.search, mode: 'insensitive' } },
          { phone: { contains: query.search } },
          { email: { contains: query.search, mode: 'insensitive' } },
        ],
      };
    }

    try {
      const [items, total] = await Promise.all([
        this.prisma.customer.findMany({
          where,
          skip,
          take: limit,
          include: { user: true },
          orderBy: { createdAt: 'desc' },
        }),
        this.prisma.customer.count({ where }),
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

  async findById(id: string) {
    return this.prisma.customer.findUnique({
      where: { id },
      include: { user: true },
    });
  }
}
