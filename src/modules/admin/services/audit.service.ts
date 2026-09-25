import { Injectable } from '@nestjs/common';
import { AdminRepository } from '../repositories/admin.repository';
import { AuditLogQueryDto } from '../dto/audit-log-query.dto';

interface CreateAuditLogParams {
  actorId: string;
  actorRole: string;
  action: string;
  entityType: string;
  entityId: string;
  oldValues?: object;
  newValues?: object;
  ip?: string;
  userAgent?: string;
}

@Injectable()
export class AuditService {
  constructor(private readonly adminRepository: AdminRepository) {}

  async log(params: CreateAuditLogParams) {
    return this.adminRepository.createAuditLog(params);
  }

  async getLogs(query: AuditLogQueryDto) {
    return this.adminRepository.getAuditLogs(query);
  }
}
