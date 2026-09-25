import { Injectable, HttpStatus } from '@nestjs/common';
import { SupportRepository } from '../repositories/support.repository';
import { CreateTicketDto } from '../dto/create-ticket.dto';
import { TicketQueryDto, TicketStatus } from '../dto/ticket-query.dto';
import { PaginationDto } from '../../../common/dto/pagination.dto';
import { AppException } from '../../../common/exceptions/app.exception';

@Injectable()
export class SupportService {
  constructor(private readonly supportRepo: SupportRepository) {}

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
    const ticket = await this.supportRepo.findById(id);
    if (!ticket) {
      throw new AppException('ERROR', 'Ticket not found', HttpStatus.NOT_FOUND);
    }
    return ticket;
  }

  async updateTicketStatus(id: string, status: TicketStatus, assignedTo?: string) {
    await this.getTicketById(id);
    return this.supportRepo.update(id, { status, assignedTo });
  }

  async assignTicket(id: string, adminId: string) {
    await this.getTicketById(id);
    return this.supportRepo.update(id, { assignedTo: adminId });
  }
}
