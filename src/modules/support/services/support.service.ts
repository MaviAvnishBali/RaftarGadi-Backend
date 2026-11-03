import { Injectable, HttpStatus, NotFoundException, ForbiddenException } from '@nestjs/common';
import { EventEmitter2 } from '@nestjs/event-emitter';
import { SupportRepository } from '../repositories/support.repository';
import { CreateTicketDto } from '../dto/create-ticket.dto';
import { TicketQueryDto, TicketStatus } from '../dto/ticket-query.dto';
import { StartChatSessionDto } from '../dto/start-chat-session.dto';
import { CreateMessageDto } from '../dto/create-message.dto';
import { PaginationDto } from '../../../common/dto/pagination.dto';
import { AppException } from '../../../common/exceptions/app.exception';

@Injectable()
export class SupportService {
  constructor(
    private readonly supportRepo: SupportRepository,
    private readonly eventEmitter: EventEmitter2,
  ) {}

  async getOrCreateSession(userId: string, dto: StartChatSessionDto) {
    const active = await this.supportRepo.findActiveByUserId(userId, dto.bookingId);
    if (active) {
      if (dto.initialMessage) {
        await this.sendMessage(active.id, userId, 'CUSTOMER', dto.initialMessage);
        return this.supportRepo.findByIdWithMessages(active.id);
      }
      return active;
    }

    const ticket = await this.supportRepo.create({
      userId,
      bookingId: dto.bookingId || null,
      subject: dto.subject || (dto.bookingId ? 'Trip Support' : 'Customer Support'),
      description: dto.initialMessage || 'Customer opened live support chat',
      priority: 'MEDIUM',
      status: 'OPEN',
    });

    if (dto.initialMessage) {
      await this.sendMessage(ticket.id, userId, 'CUSTOMER', dto.initialMessage);
      return this.supportRepo.findByIdWithMessages(ticket.id);
    }

    return ticket;
  }

  async getActiveSession(userId: string, bookingId?: string) {
    return this.supportRepo.findActiveByUserId(userId, bookingId);
  }

  async getMessages(ticketId: string, currentUserId: string, currentUserRole: string) {
    const ticket = await this.supportRepo.findById(ticketId);
    if (!ticket) {
      throw new NotFoundException('Ticket not found');
    }

    const isStaff = currentUserRole === 'ADMIN' || currentUserRole === 'SUPER_ADMIN';
    if (!isStaff && ticket.userId !== currentUserId) {
      throw new ForbiddenException('You cannot access this support ticket');
    }

    // Mark other party's messages as read
    await this.supportRepo.markMessagesAsRead(
      ticketId,
      isStaff ? 'SUPPORT_AGENT' : 'CUSTOMER',
    );

    return this.supportRepo.getMessagesByTicketId(ticketId);
  }

  async sendMessage(
    ticketId: string,
    senderId: string,
    senderRole: string,
    text: string,
  ) {
    const ticket = await this.supportRepo.findById(ticketId);
    if (!ticket) {
      throw new NotFoundException('Support ticket not found');
    }

    const isStaff = senderRole === 'ADMIN' || senderRole === 'SUPER_ADMIN' || senderRole === 'SUPPORT_AGENT';
    if (!isStaff && ticket.userId !== senderId) {
      throw new ForbiddenException('You cannot post to this support ticket');
    }

    const normalizedRole = isStaff ? 'SUPPORT_AGENT' : 'CUSTOMER';

    // Auto-advance ticket status to IN_PROGRESS when agent responds
    if (isStaff && ticket.status === 'OPEN') {
      await this.supportRepo.update(ticketId, {
        status: 'IN_PROGRESS',
        assignedTo: ticket.assignedTo || senderId,
      });
    }

    const msg = await this.supportRepo.createMessage({
      ticketId,
      senderId,
      senderRole: normalizedRole,
      message: text.trim(),
    });

    // Broadcast live over WebSocket to all participants in this ticket's room
    this.eventEmitter.emit('support.message', {
      ticketId,
      message: msg,
    });

    return msg;
  }

  async createTicket(userId: string, dto: CreateTicketDto) {
    return this.supportRepo.create({
      userId,
      bookingId: dto.bookingId,
      subject: dto.subject,
      description: dto.description,
      priority: dto.priority || 'LOW',
      status: 'OPEN',
    });
  }

  async getMyTickets(userId: string, query: PaginationDto) {
    const skip = (query.page - 1) * query.limit;
    const [items, total] = await Promise.all([
      this.supportRepo.findByUserId(userId, skip, query.limit),
      this.supportRepo.countByUserId(userId),
    ]);

    return {
      items,
      meta: {
        total,
        page: query.page,
        limit: query.limit,
        totalPages: Math.ceil(total / query.limit),
      },
    };
  }

  async getAllTickets(query: TicketQueryDto) {
    const skip = (query.page - 1) * query.limit;
    const where: any = {};
    if (query.status) where.status = query.status;
    if (query.priority) where.priority = query.priority;
    if (query.assignedTo) where.assignedTo = query.assignedTo;

    const [items, total] = await Promise.all([
      this.supportRepo.findAll(where, skip, query.limit),
      this.supportRepo.countAll(where),
    ]);

    return {
      items,
      meta: {
        total,
        page: query.page,
        limit: query.limit,
        totalPages: Math.ceil(total / query.limit),
      },
    };
  }

  async getTicketById(id: string) {
    const ticket = await this.supportRepo.findByIdWithMessages(id);
    if (!ticket) {
      throw new AppException('ERROR', 'Ticket not found', HttpStatus.NOT_FOUND);
    }
    return ticket;
  }

  async updateTicketStatus(id: string, status: TicketStatus, assignedTo?: string) {
    await this.getTicketById(id);
    const updateData: any = { status };
    if (assignedTo !== undefined) {
      updateData.assignedTo = assignedTo;
    }

    const updated = await this.supportRepo.update(id, updateData);

    // Notify room of status change
    this.eventEmitter.emit('support.message', {
      ticketId: id,
      message: {
        id: `sys_${Date.now()}`,
        ticketId: id,
        senderRole: 'SYSTEM',
        message: `Ticket status updated to ${status}.`,
        createdAt: new Date().toISOString(),
      },
    });

    return updated;
  }

  async assignTicket(id: string, adminId: string) {
    await this.getTicketById(id);
    return this.supportRepo.update(id, { assignedTo: adminId });
  }
}
