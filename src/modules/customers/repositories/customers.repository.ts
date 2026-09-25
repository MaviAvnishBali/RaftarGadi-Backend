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
    return this.prisma.customer.update({
      where: { userId },
      data: dto,
      include: { user: true },
    });
  }

  async findAll(query: PaginationDto) {
    const page = query.page || 1;
    const limit = query.limit || 10;
    const skip = (page - 1) * limit;

    const [items, total] = await Promise.all([
      this.prisma.customer.findMany({
        skip,
        take: limit,
        include: { user: true },
      }),
      this.prisma.customer.count(),
    ]);

    return {
      items,
      total,
      page,
      limit,
      totalPages: Math.ceil(total / limit),
    };
  }

  async findById(id: string) {
    return this.prisma.customer.findUnique({
      where: { id },
      include: { user: true },
    });
  }
}
