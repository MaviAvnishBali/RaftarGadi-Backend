import { WalletTransactionType } from '@prisma/client';
import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';
import { WalletsRepository } from '../repositories/wallets.repository';

import { AppException } from '../../../common/exceptions/app.exception';
import { WalletQueryDto } from '../dto/wallet-query.dto';

@Injectable()
export class WalletsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly walletsRepo: WalletsRepository,
  ) {}

  private round(value: number): number {
    return Math.round(value * 100) / 100;
  }

  async getOrCreateWallet(driverId: string) {
    let wallet = await this.walletsRepo.getWalletByDriverId(driverId);
    if (!wallet) {
      wallet = await this.walletsRepo.createWallet(driverId);
    }
    return wallet;
  }

  async getWallet(driverId: string) {
    const wallet = await this.walletsRepo.getWalletByDriverId(driverId);
    if (!wallet) throw new AppException('ERROR', 'Wallet not found', 404);
    return wallet;
  }

  async getBalance(driverId: string): Promise<number> {
    const wallet = await this.getWallet(driverId);
    return Number(wallet.balance);
  }

  async creditEarning(
    driverId: string,
    bookingId: string,
    amount: number,
    description: string,
    idempotencyKey?: string,
  ) {
    amount = this.round(amount);
    const wallet = await this.getOrCreateWallet(driverId);

    return this.prisma.$transaction(async (tx) => {
      const updatedWallet = await tx.driverWallet.update({
        where: { id: wallet.id },
        data: {
          balance: { increment: amount },
          totalEarned: { increment: amount },
        },
      });

      return tx.walletTransaction.create({
        data: {
          walletId: wallet.id,
          type: WalletTransactionType.TRIP_EARNING,
          amount,
          balanceAfter: updatedWallet.balance,
          description,
          referenceId: bookingId,
          idempotencyKey,
        },
      });
    });
  }

  async deductCommission(driverId: string, bookingId: string, amount: number, description: string) {
    amount = this.round(amount);
    const wallet = await this.getWallet(driverId);

    return this.prisma.$transaction(async (tx) => {
      const updatedWallet = await tx.driverWallet.update({
        where: { id: wallet.id },
        data: { balance: { decrement: amount } },
      });

      return tx.walletTransaction.create({
        data: {
          walletId: wallet.id,
          type: WalletTransactionType.PLATFORM_COMMISSION,
          amount: -amount,
          balanceAfter: updatedWallet.balance,
          description,
          referenceId: bookingId,
        },
      });
    });
  }

  async addBonus(driverId: string, amount: number, description: string) {
    amount = this.round(amount);
    const wallet = await this.getOrCreateWallet(driverId);

    return this.prisma.$transaction(async (tx) => {
      const updatedWallet = await tx.driverWallet.update({
        where: { id: wallet.id },
        data: {
          balance: { increment: amount },
          totalEarned: { increment: amount },
        },
      });

      return tx.walletTransaction.create({
        data: {
          walletId: wallet.id,
          type: WalletTransactionType.BONUS,
          amount,
          balanceAfter: updatedWallet.balance,
          description,
        },
      });
    });
  }

  async applyPenalty(driverId: string, amount: number, description: string) {
    amount = this.round(amount);
    const wallet = await this.getWallet(driverId);

    return this.prisma.$transaction(async (tx) => {
      const updatedWallet = await tx.driverWallet.update({
        where: { id: wallet.id },
        data: { balance: { decrement: amount } },
      });

      return tx.walletTransaction.create({
        data: {
          walletId: wallet.id,
          type: WalletTransactionType.PENALTY,
          amount: -amount,
          balanceAfter: updatedWallet.balance,
          description,
        },
      });
    });
  }

  async processWithdrawal(driverId: string, amount: number) {
    amount = this.round(amount);
    const wallet = await this.getWallet(driverId);

    if (Number(wallet.balance) < amount) {
      throw new AppException('ERROR', 'Insufficient balance', 400);
    }

    return this.prisma.$transaction(async (tx) => {
      const updatedWallet = await tx.driverWallet.update({
        where: { id: wallet.id },
        data: {
          balance: { decrement: amount },
          totalWithdrawn: { increment: amount },
        },
      });

      return tx.walletTransaction.create({
        data: {
          walletId: wallet.id,
          type: WalletTransactionType.WITHDRAWAL,
          amount: -amount,
          balanceAfter: updatedWallet.balance,
          description: 'Funds withdrawal',
        },
      });
    });
  }

  async getTransactions(walletId: string, query: WalletQueryDto) {
    return this.walletsRepo.getTransactions(walletId, query);
  }

  async processBookingEarning(
    bookingId: string,
    driverId: string,
    fareAmount: number,
    commissionPercent: number,
  ) {
    fareAmount = this.round(fareAmount);
    const commission = this.round(fareAmount * (commissionPercent / 100));
    const wallet = await this.getOrCreateWallet(driverId);

    await this.prisma.$transaction(async (tx) => {
      let updatedWallet = await tx.driverWallet.update({
        where: { id: wallet.id },
        data: {
          balance: { increment: fareAmount },
          totalEarned: { increment: fareAmount },
        },
      });

      await tx.walletTransaction.create({
        data: {
          walletId: wallet.id,
          type: WalletTransactionType.TRIP_EARNING,
          amount: fareAmount,
          balanceAfter: updatedWallet.balance,
          description: 'Trip Earning',
          referenceId: bookingId,
        },
      });

      updatedWallet = await tx.driverWallet.update({
        where: { id: wallet.id },
        data: { balance: { decrement: commission } },
      });

      await tx.walletTransaction.create({
        data: {
          walletId: wallet.id,
          type: WalletTransactionType.PLATFORM_COMMISSION,
          amount: -commission,
          balanceAfter: updatedWallet.balance,
          description: 'Trip Commission',
          referenceId: bookingId,
        },
      });
    });
  }
}
