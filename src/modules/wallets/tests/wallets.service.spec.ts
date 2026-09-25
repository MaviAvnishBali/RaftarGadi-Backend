import { Test, TestingModule } from '@nestjs/testing';
import { WalletsService } from '../services/wallets.service';
import { WalletsRepository } from '../repositories/wallets.repository';
import { PrismaService } from '../../../database/prisma.service';
import { AppException } from '../../../common/exceptions/app.exception';

describe('WalletsService', () => {
  let service: WalletsService;
  let repo: WalletsRepository;
  let prisma: PrismaService;

  const mockWallet = {
    id: 'wallet-123',
    driverId: 'driver-123',
    balance: 100,
    totalEarned: 100,
    totalWithdrawn: 0,
  };

  const mockWalletsRepository = {
    getWalletByDriverId: jest.fn(),
    createWallet: jest.fn(),
  };

  const mockPrismaService = {
    $transaction: jest.fn((callback) => callback(mockPrismaTx)),
    driverWallet: {
      update: jest.fn(),
    },
    walletTransaction: {
      create: jest.fn(),
    },
  };

  const mockPrismaTx = {
    driverWallet: {
      update: jest.fn(),
    },
    walletTransaction: {
      create: jest.fn(),
    },
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        WalletsService,
        { provide: WalletsRepository, useValue: mockWalletsRepository },
        { provide: PrismaService, useValue: mockPrismaService },
      ],
    }).compile();

    service = module.get<WalletsService>(WalletsService);
    repo = module.get<WalletsRepository>(WalletsRepository);
    prisma = module.get<PrismaService>(PrismaService);

    jest.clearAllMocks();
  });

  describe('getOrCreateWallet', () => {
    it('should return existing wallet if found', async () => {
      mockWalletsRepository.getWalletByDriverId.mockResolvedValueOnce(mockWallet);

      const result = await service.getOrCreateWallet('driver-123');
      expect(result).toEqual(mockWallet);
      expect(mockWalletsRepository.createWallet).not.toHaveBeenCalled();
    });

    it('should create new wallet if not found', async () => {
      mockWalletsRepository.getWalletByDriverId.mockResolvedValueOnce(null);
      mockWalletsRepository.createWallet.mockResolvedValueOnce(mockWallet);

      const result = await service.getOrCreateWallet('driver-123');
      expect(result).toEqual(mockWallet);
      expect(mockWalletsRepository.createWallet).toHaveBeenCalledWith('driver-123');
    });
  });

  describe('creditEarning', () => {
    it('should increase balance correctly', async () => {
      mockWalletsRepository.getWalletByDriverId.mockResolvedValueOnce(mockWallet);
      mockPrismaTx.driverWallet.update.mockResolvedValueOnce({ ...mockWallet, balance: 150 });
      mockPrismaTx.walletTransaction.create.mockResolvedValueOnce({ id: 'tx-1' });

      await service.creditEarning('driver-123', 'booking-1', 50, 'Earning');

      expect(mockPrismaTx.driverWallet.update).toHaveBeenCalledWith({
        where: { id: mockWallet.id },
        data: {
          balance: { increment: 50 },
          totalEarned: { increment: 50 },
        },
      });
      expect(mockPrismaTx.walletTransaction.create).toHaveBeenCalled();
    });
  });

  describe('deductCommission', () => {
    it('should decrease balance correctly', async () => {
      mockWalletsRepository.getWalletByDriverId.mockResolvedValueOnce(mockWallet);
      mockPrismaTx.driverWallet.update.mockResolvedValueOnce({ ...mockWallet, balance: 80 });
      mockPrismaTx.walletTransaction.create.mockResolvedValueOnce({ id: 'tx-2' });

      await service.deductCommission('driver-123', 'booking-1', 20, 'Commission');

      expect(mockPrismaTx.driverWallet.update).toHaveBeenCalledWith({
        where: { id: mockWallet.id },
        data: { balance: { decrement: 20 } },
      });
      expect(mockPrismaTx.walletTransaction.create).toHaveBeenCalled();
    });
  });

  describe('processWithdrawal', () => {
    it('should fail with insufficient balance', async () => {
      mockWalletsRepository.getWalletByDriverId.mockResolvedValueOnce(mockWallet); // balance is 100

      await expect(service.processWithdrawal('driver-123', 150)).rejects.toThrow(AppException);
      expect(mockPrismaTx.driverWallet.update).not.toHaveBeenCalled();
    });

    it('should succeed with sufficient balance', async () => {
      mockWalletsRepository.getWalletByDriverId.mockResolvedValueOnce(mockWallet);
      mockPrismaTx.driverWallet.update.mockResolvedValueOnce({ ...mockWallet, balance: 50 });
      mockPrismaTx.walletTransaction.create.mockResolvedValueOnce({ id: 'tx-3' });

      await service.processWithdrawal('driver-123', 50);

      expect(mockPrismaTx.driverWallet.update).toHaveBeenCalledWith({
        where: { id: mockWallet.id },
        data: {
          balance: { decrement: 50 },
          totalWithdrawn: { increment: 50 },
        },
      });
    });
  });

  describe('idempotency', () => {
    it('should pass idempotencyKey to wallet transaction creation', async () => {
      mockWalletsRepository.getWalletByDriverId.mockResolvedValueOnce(mockWallet);
      mockPrismaTx.driverWallet.update.mockResolvedValueOnce({ ...mockWallet, balance: 150 });
      mockPrismaTx.walletTransaction.create.mockResolvedValueOnce({ id: 'tx-4' });

      await service.creditEarning('driver-123', 'booking-1', 50, 'Earning', 'idempotency-123');

      expect(mockPrismaTx.walletTransaction.create).toHaveBeenCalledWith(
        expect.objectContaining({
          data: expect.objectContaining({ idempotencyKey: 'idempotency-123' }),
        }),
      );
    });
  });
});
