import { Module } from '@nestjs/common';
import { WalletsService } from './services/wallets.service';
import { WalletsController } from './controllers/wallets.controller';
import { WalletsRepository } from './repositories/wallets.repository';
import { PrismaService } from '../../database/prisma.service';

@Module({
  controllers: [WalletsController],
  providers: [WalletsService, WalletsRepository, PrismaService],
  exports: [WalletsService],
})
export class WalletsModule {}
