import { Injectable } from '@nestjs/common';
import { AdminRepository } from '../repositories/admin.repository';
import { ReportsService } from '../../reports/services/reports.service';
import { AuditService } from './audit.service';
import { AuditLogQueryDto } from '../dto/audit-log-query.dto';
import { DashboardStats } from '../../reports/interfaces/report.interfaces';

@Injectable()
export class AdminService {
  constructor(
    private readonly adminRepository: AdminRepository,
    private readonly reportsService: ReportsService,
    private readonly auditService: AuditService,
  ) {}

  async getOverview(): Promise<DashboardStats> {
    return this.reportsService.getDashboardStats();
  }

  async manageUser(userId: string, action: 'activate' | 'deactivate') {
    return this.adminRepository.manageUser(userId, action);
  }

  async auditLog(
    actorId: string,
    actorRole: string,
    action: string,
    entityType: string,
    entityId: string,
    oldValues?: object,
    newValues?: object,
    ip?: string,
    userAgent?: string,
  ) {
    return this.auditService.log({
      actorId,
      actorRole,
      action,
      entityType,
      entityId,
      oldValues,
      newValues,
      ip,
      userAgent,
    });
  }

  async getAuditLogs(query: AuditLogQueryDto) {
    return this.auditService.getLogs(query);
  }
}
