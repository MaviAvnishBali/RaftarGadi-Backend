import { Controller, Post, Get, Patch, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { SupportService } from '../services/support.service';
import { CreateTicketDto } from '../dto/create-ticket.dto';
import { TicketQueryDto, TicketStatus } from '../dto/ticket-query.dto';
import { UpdateTicketDto } from '../dto/update-ticket.dto';
import { StartChatSessionDto } from '../dto/start-chat-session.dto';
import { CreateMessageDto } from '../dto/create-message.dto';
import { PaginationDto } from '../../../common/dto/pagination.dto';
import { CurrentUser, Roles } from '../../../common/decorators';
import { Role } from '../../../common/enums';

@ApiTags('Support')
@ApiBearerAuth('access-token')
@Controller({ version: '1', path: 'support' })
export class SupportController {
  constructor(private readonly supportService: SupportService) {}

  @Post('chat/session')
  @ApiOperation({ summary: 'Customer: Start or resume active live support chat session' })
  async startChatSession(
    @CurrentUser('sub') userId: string,
    @Body() dto: StartChatSessionDto,
  ) {
    return this.supportService.getOrCreateSession(userId, dto);
  }

  @Get('tickets/active')
  @ApiOperation({ summary: 'Customer: Get latest active support session' })
  @ApiQuery({ name: 'bookingId', required: false })
  async getActiveSession(
    @CurrentUser('sub') userId: string,
    @Query('bookingId') bookingId?: string,
  ) {
    return this.supportService.getActiveSession(userId, bookingId);
  }

  @Get('tickets/:id/messages')
  @ApiOperation({ summary: 'Customer & Admin: Get message history for ticket' })
  async getTicketMessages(
    @CurrentUser() user: any,
    @Param('id') id: string,
  ) {
    return this.supportService.getMessages(id, user.sub, user.role);
  }

  @Post('tickets/:id/messages')
  @ApiOperation({ summary: 'Customer & Admin: Post a message to support chat' })
  async sendMessage(
    @CurrentUser() user: any,
    @Param('id') id: string,
    @Body() dto: CreateMessageDto,
  ) {
    return this.supportService.sendMessage(id, user.sub, user.role, dto.message);
  }

  @Patch('tickets/:id/status')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @ApiOperation({ summary: 'Admin: Update ticket status or assignee' })
  async updateStatus(
    @Param('id') id: string,
    @Body('status') status: TicketStatus,
    @Body('assignedTo') assignedTo?: string,
  ) {
    return this.supportService.updateTicketStatus(id, status, assignedTo);
  }

  // ── Existing / Compatibility ticket endpoints ──────────────

  @Post('tickets')
  @ApiOperation({ summary: 'Create a support ticket' })
  async createTicket(@CurrentUser('sub') userId: string, @Body() dto: CreateTicketDto) {
    return this.supportService.createTicket(userId, dto);
  }

  @Get('tickets/my')
  @ApiOperation({ summary: 'Get my support tickets' })
  async getMyTickets(@CurrentUser('sub') userId: string, @Query() query: PaginationDto) {
    return this.supportService.getMyTickets(userId, query);
  }

  @Get('tickets')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @ApiOperation({ summary: 'Admin: Get all support tickets with customer info' })
  async getAllTickets(@Query() query: TicketQueryDto) {
    return this.supportService.getAllTickets(query);
  }

  @Get('tickets/:id')
  @ApiOperation({ summary: 'Get a specific ticket' })
  async getTicketById(@Param('id') id: string) {
    return this.supportService.getTicketById(id);
  }

  @Patch('tickets/:id')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @ApiOperation({ summary: 'Update a ticket' })
  async updateTicket(@Param('id') id: string, @Body() dto: UpdateTicketDto) {
    return this.supportService.updateTicketStatus(id, dto.status, dto.assignedTo);
  }
}
