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

  async resolveDriverId(id: string): Promise<string> {
    const driverById = await this.prisma.driver.findUnique({ where: { id } });
    if (driverById) return driverById.id;
    const driverByUser = await this.prisma.driver.findUnique({ where: { userId: id } });
    if (driverByUser) return driverByUser.id;
    throw new AppException('ERROR', 'Driver not found', 404);
  }

  async getOrCreateWallet(driverIdOrUserId: string) {
    const resolvedDriverId = await this.resolveDriverId(driverIdOrUserId);
    let wallet = await this.walletsRepo.getWalletByDriverId(resolvedDriverId);
    if (!wallet) {
      wallet = await this.walletsRepo.createWallet(resolvedDriverId);
    }
    return wallet;
  }

  async getWallet(driverIdOrUserId: string) {
    const resolvedDriverId = await this.resolveDriverId(driverIdOrUserId);
    const wallet = await this.walletsRepo.getWalletByDriverId(resolvedDriverId);
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
    if (amount <= 0) {
      throw new AppException('BAD_REQUEST', 'Withdrawal amount must be greater than zero', 400);
    }

    const wallet = await this.getWallet(driverId);

    return this.prisma.$transaction(async (tx) => {
      // Atomic conditional update: only decrement if balance is strictly greater than or equal to amount
      const updateResult = await tx.driverWallet.updateMany({
        where: {
          id: wallet.id,
          balance: { gte: amount },
        },
        data: {
          balance: { decrement: amount },
          totalWithdrawn: { increment: amount },
        },
      });

      if (updateResult.count === 0) {
        throw new AppException('ERROR', 'Insufficient balance or concurrent withdrawal in progress', 400);
      }

      const updatedWallet = await tx.driverWallet.findUnique({
        where: { id: wallet.id },
      });

      return tx.walletTransaction.create({
        data: {
          walletId: wallet.id,
          type: WalletTransactionType.WITHDRAWAL,
          amount: -amount,
          balanceAfter: updatedWallet ? updatedWallet.balance : 0,
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
