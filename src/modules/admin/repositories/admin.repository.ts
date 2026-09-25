import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';

@Injectable()
export class AdminRepository {
  constructor(private readonly prisma: PrismaService) {}

  async manageUser(userId: string, action: 'activate' | 'deactivate') {
    return { id: userId, active: action === 'activate' };
  }

  async getAuditLogs(query: any) {
    return {
      data: [],
      meta: {
        total: 0,
        page: 1,
        limit: 10,
        totalPages: 0,
      },
    };
  }

  async createAuditLog(data: any) {
    return { id: 'uuid', ...data };
  }
}
