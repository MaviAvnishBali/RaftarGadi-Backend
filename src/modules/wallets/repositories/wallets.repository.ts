import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';
import { WalletQueryDto } from '../dto/wallet-query.dto';

@Injectable()
export class WalletsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async getWalletByDriverId(driverId: string) {
    return this.prisma.driverWallet.findUnique({ where: { driverId } });
  }

  async createWallet(driverId: string) {
    return this.prisma.driverWallet.create({
      data: { driverId, balance: 0, totalEarned: 0, totalWithdrawn: 0 },
    });
  }

  async getTransactions(walletId: string, query: WalletQueryDto) {
    const page = query.page || 1;
    const limit = query.limit || 10;
    const skip = (page - 1) * limit;

    const where: any = { walletId };
    if (query.type) where.type = query.type;
    if (query.from || query.to) {
      where.createdAt = {};
      if (query.from) where.createdAt.gte = new Date(query.from);
      if (query.to) where.createdAt.lte = new Date(query.to);
    }

    const [items, total] = await Promise.all([
      this.prisma.walletTransaction.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
      }),
      this.prisma.walletTransaction.count({ where }),
    ]);

    return { items, total, page, limit, totalPages: Math.ceil(total / limit) };
  }
}
