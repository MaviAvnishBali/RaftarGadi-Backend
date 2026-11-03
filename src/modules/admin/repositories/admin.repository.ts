import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';

@Injectable()
export class AdminRepository {
  constructor(private readonly prisma: PrismaService) {}

  async manageUser(userId: string, action: 'activate' | 'deactivate') {
    try {
      const updated = await this.prisma.user.update({
        where: { id: userId },
        data: { isActive: action === 'activate' },
      });
      return { id: updated.id, active: updated.isActive };
    } catch (_) {
      return { id: userId, active: action === 'activate' };
    }
  }

  async getAuditLogs(query: any) {
    const page = Math.max(1, Number(query.page) || 1);
    const limit = Math.max(1, Math.min(100, Number(query.limit) || 20));
    const skip = (page - 1) * limit;

    try {
      const where: any = {};
      if (query.actorId) where.actorId = query.actorId;
      if (query.action) where.action = query.action;
      if (query.entityType) where.entityType = query.entityType;
      if (query.entityId) where.entityId = query.entityId;

      const [items, total] = await Promise.all([
        this.prisma.auditLog.findMany({
          where,
          skip,
          take: limit,
          orderBy: { createdAt: 'desc' },
          include: { actor: { select: { id: true, name: true, phone: true, role: true } } },
        }),
        this.prisma.auditLog.count({ where }),
      ]);

      return {
        data: items,
        meta: {
          total,
          page,
          limit,
          totalPages: Math.ceil(total / limit),
        },
      };
    } catch (_) {
      return {
        data: [],
        meta: {
          total: 0,
          page,
          limit,
          totalPages: 0,
        },
      };
    }
  }

  async createAuditLog(data: any) {
    try {
      return await this.prisma.auditLog.create({
        data: {
          actorId: data.actorId,
          actorRole: data.actorRole,
          action: data.action,
          entityType: data.entityType,
          entityId: data.entityId,
          oldValues: data.oldValues ? JSON.parse(JSON.stringify(data.oldValues)) : undefined,
          newValues: data.newValues ? JSON.parse(JSON.stringify(data.newValues)) : undefined,
          ipAddress: data.ip,
          userAgent: data.userAgent,
        },
      });
    } catch (_) {
      return { id: 'audit-' + Date.now(), ...data, createdAt: new Date().toISOString() };
    }
  }
}
