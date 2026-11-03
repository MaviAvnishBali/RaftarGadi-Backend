import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';

@Injectable()
export class SupportRepository {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: any) {
    return this.prisma.supportTicket.create({
      data,
      include: {
        user: { select: { id: true, name: true, phone: true, email: true } },
        assignee: { select: { id: true, name: true } },
        messages: {
          orderBy: { createdAt: 'asc' },
          include: { sender: { select: { id: true, name: true, role: true } } },
        },
      },
    });
  }

  async findById(id: string) {
    return this.prisma.supportTicket.findUnique({
      where: { id },
      include: {
        user: { select: { id: true, name: true, phone: true, email: true } },
        assignee: { select: { id: true, name: true } },
      },
    });
  }

  async findByIdWithMessages(id: string) {
    return this.prisma.supportTicket.findUnique({
      where: { id },
      include: {
        user: { select: { id: true, name: true, phone: true, email: true } },
        assignee: { select: { id: true, name: true } },
        messages: {
          orderBy: { createdAt: 'asc' },
          include: { sender: { select: { id: true, name: true, role: true } } },
        },
      },
    });
  }

  async findActiveByUserId(userId: string, bookingId?: string) {
    const where: any = {
      userId,
      status: { in: ['OPEN', 'IN_PROGRESS'] },
    };
    if (bookingId) {
      where.bookingId = bookingId;
    }

    return this.prisma.supportTicket.findFirst({
      where,
      orderBy: { updatedAt: 'desc' },
      include: {
        user: { select: { id: true, name: true, phone: true, email: true } },
        assignee: { select: { id: true, name: true } },
        messages: {
          orderBy: { createdAt: 'asc' },
          include: { sender: { select: { id: true, name: true, role: true } } },
        },
      },
    });
  }

  async findByUserId(userId: string, skip: number, take: number) {
    return this.prisma.supportTicket.findMany({
      where: { userId },
      skip,
      take,
      orderBy: { createdAt: 'desc' },
      include: {
        assignee: { select: { id: true, name: true } },
        messages: {
          take: 1,
          orderBy: { createdAt: 'desc' },
        },
      },
    });
  }

  async countByUserId(userId: string) {
    return this.prisma.supportTicket.count({
      where: { userId },
    });
  }

  async findAll(where: any, skip: number, take: number) {
    return this.prisma.supportTicket.findMany({
      where,
      skip,
      take,
      orderBy: { updatedAt: 'desc' },
      include: {
        user: { select: { id: true, name: true, phone: true, email: true } },
        assignee: { select: { id: true, name: true } },
        messages: {
          take: 1,
          orderBy: { createdAt: 'desc' },
        },
      },
    });
  }

  async countAll(where: any) {
    return this.prisma.supportTicket.count({ where });
  }

  async update(id: string, data: any) {
    return this.prisma.supportTicket.update({
      where: { id },
      data,
      include: {
        user: { select: { id: true, name: true, phone: true, email: true } },
        assignee: { select: { id: true, name: true } },
      },
    });
  }

  async createMessage(data: {
    ticketId: string;
    senderId?: string | null;
    senderRole: string;
    message: string;
  }) {
    const [msg] = await this.prisma.$transaction([
      this.prisma.supportMessage.create({
        data: {
          ticketId: data.ticketId,
          senderId: data.senderId || null,
          senderRole: data.senderRole,
          message: data.message,
        },
        include: {
          sender: { select: { id: true, name: true, role: true } },
        },
      }),
      this.prisma.supportTicket.update({
        where: { id: data.ticketId },
        data: { updatedAt: new Date() },
      }),
    ]);
    return msg;
  }

  async getMessagesByTicketId(ticketId: string) {
    return this.prisma.supportMessage.findMany({
      where: { ticketId },
      orderBy: { createdAt: 'asc' },
      include: {
        sender: { select: { id: true, name: true, role: true } },
      },
    });
  }

  async markMessagesAsRead(ticketId: string, roleExcluding: string) {
    return this.prisma.supportMessage.updateMany({
      where: {
        ticketId,
        senderRole: { not: roleExcluding },
        isRead: false,
      },
      data: { isRead: true },
    });
  }
}
