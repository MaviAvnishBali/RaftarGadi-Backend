import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';

@Injectable()
export class SupportRepository {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: any) {
    return this.prisma.supportTicket.create({ data });
  }

  async findById(id: string) {
    return this.prisma.supportTicket.findUnique({
      where: { id },
    });
  }

  async findByUserId(userId: string, skip: number, take: number) {
    return this.prisma.supportTicket.findMany({
      where: { userId },
      skip,
      take,
      orderBy: { createdAt: 'desc' },
    });
  }

  async countByUserId(userId: string) {
    return this.prisma.supportTicket.count({
      where: { userId },
    });
  }

  async findAll(where: any, skip: number, take: number) {
    return this.prisma.supportTicket.findMany({
      where,
      skip,
      take,
      orderBy: { createdAt: 'desc' },
    });
  }

  async countAll(where: any) {
    return this.prisma.supportTicket.count({ where });
  }

  async update(id: string, data: any) {
    return this.prisma.supportTicket.update({
      where: { id },
      data,
    });
  }
}
