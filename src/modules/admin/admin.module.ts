import { Module } from '@nestjs/common';
import { AdminController } from './controllers/admin.controller';
import { AdminService } from './services/admin.service';
import { AuditService } from './services/audit.service';
import { AdminRepository } from './repositories/admin.repository';
import { ReportsModule } from '../reports/reports.module';
import { PrismaService } from '../../database/prisma.service';

@Module({
  imports: [ReportsModule],
  controllers: [AdminController],
  providers: [AdminService, AuditService, AdminRepository, PrismaService],
})
export class AdminModule {}
