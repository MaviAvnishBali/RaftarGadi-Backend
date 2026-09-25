import { Module } from '@nestjs/common';
import { ReportsController } from './controllers/reports.controller';
import { ReportsService } from './services/reports.service';
import { ReportsRepository } from './repositories/reports.repository';
import { PrismaService } from '../../database/prisma.service';

@Module({
  controllers: [ReportsController],
  providers: [ReportsService, ReportsRepository, PrismaService],
  exports: [ReportsService],
})
export class ReportsModule {}
