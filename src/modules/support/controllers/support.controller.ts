import { Controller, Post, Get, Patch, Body, Param, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { SupportService } from '../services/support.service';
import { CreateTicketDto } from '../dto/create-ticket.dto';
import { TicketQueryDto } from '../dto/ticket-query.dto';
import { UpdateTicketDto } from '../dto/update-ticket.dto';
import { PaginationDto } from '../../../common/dto/pagination.dto';
import { CurrentUser, Roles } from '../../../common/decorators';
import { Role } from '../../../common/enums';

@ApiTags('Support')
@ApiBearerAuth('access-token')
@Controller({ version: '1', path: 'support/tickets' })
export class SupportController {
  constructor(private readonly supportService: SupportService) {}

  @Post()
  @ApiOperation({ summary: 'Create a support ticket' })
  async createTicket(@CurrentUser() user: any, @Body() dto: CreateTicketDto) {
    return this.supportService.createTicket(user.sub, dto);
  }

  @Get('my')
  @ApiOperation({ summary: 'Get my support tickets' })
  async getMyTickets(@CurrentUser() user: any, @Query() query: PaginationDto) {
    return this.supportService.getMyTickets(user.sub, query);
  }

  @Get()
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @ApiOperation({ summary: 'Get all support tickets' })
  async getAllTickets(@Query() query: TicketQueryDto) {
    return this.supportService.getAllTickets(query);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get a specific ticket' })
  async getTicketById(@Param('id') id: string) {
    return this.supportService.getTicketById(id);
  }

  @Patch(':id')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @ApiOperation({ summary: 'Update a ticket' })
  async updateTicket(@Param('id') id: string, @Body() dto: UpdateTicketDto) {
    return this.supportService.updateTicketStatus(id, dto.status, dto.assignedTo);
  }
}
