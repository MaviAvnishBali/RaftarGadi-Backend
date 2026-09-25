import { Controller, Post, Get, Patch, Body, Param, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { NotificationsService } from '../services/notifications.service';
import { SendNotificationDto, NotificationChannel } from '../dto/send-notification.dto';
import { PaginationDto } from '../../../common/dto/pagination.dto';
import { CurrentUser, Roles } from '../../../common/decorators';
import { Role } from '../../../common/enums';

@ApiTags('Notifications')
@ApiBearerAuth('access-token')
@Controller({ version: '1', path: 'notifications' })
export class NotificationsController {
  constructor(private readonly notificationsService: NotificationsService) {}

  @Get()
  @ApiOperation({ summary: 'Get my notifications' })
  async getMyNotifications(@CurrentUser() user: any, @Query() query: PaginationDto) {
    return this.notificationsService.getMyNotifications(user.sub, query);
  }

  @Get('unread-count')
  @ApiOperation({ summary: 'Get unread notification count' })
  async getUnreadCount(@CurrentUser() user: any) {
    const count = await this.notificationsService.getUnreadCount(user.sub);
    return { count };
  }

  @Patch(':id/read')
  @ApiOperation({ summary: 'Mark a notification as read' })
  async markAsRead(@CurrentUser() user: any, @Param('id') id: string) {
    await this.notificationsService.markAsRead(id, user.sub);
    return { success: true };
  }

  @Post('read-all')
  @ApiOperation({ summary: 'Mark all notifications as read' })
  async markAllAsRead(@CurrentUser() user: any) {
    await this.notificationsService.markAllAsRead(user.sub);
    return { success: true };
  }

  @Post('send')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @ApiOperation({ summary: 'Send a notification manually' })
  async sendNotification(@Body() dto: SendNotificationDto) {
    switch (dto.channel) {
      case NotificationChannel.PUSH:
        return this.notificationsService.sendPushNotification(
          dto.userId,
          dto.title,
          dto.body,
          dto.metadata,
        );
      case NotificationChannel.SMS:
        return this.notificationsService.sendSms(dto.userId, dto.body);
      case NotificationChannel.EMAIL:
        return this.notificationsService.sendEmail(dto.userId, dto.title, dto.body);
    }
  }
}
