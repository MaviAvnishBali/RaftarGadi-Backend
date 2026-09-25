import { Injectable, Logger } from '@nestjs/common';
import { NotificationsRepository } from '../repositories/notifications.repository';
import { FcmService } from './fcm.service';
import { PaginationDto } from '../../../common/dto/pagination.dto';
import { InjectQueue } from '@nestjs/bullmq';
import { Queue } from 'bullmq';

@Injectable()
export class NotificationsService {
  private readonly logger = new Logger(NotificationsService.name);

  constructor(
    private readonly notificationsRepo: NotificationsRepository,
    private readonly fcmService: FcmService,
    @InjectQueue('notification-queue') private readonly notificationQueue: Queue,
  ) {}

  async sendPushNotification(userId: string, title: string, body: string, metadata?: object) {
    const notification = await this.notificationsRepo.create({
      userId,
      title,
      body,
      type: 'PUSH',
      metadata: metadata ? JSON.parse(JSON.stringify(metadata)) : null,
    });

    await this.notificationQueue.add('send-push', {
      userId,
      title,
      body,
      metadata,
    });

    return notification;
  }

  async sendSms(userId: string, message: string) {
    const notification = await this.notificationsRepo.create({
      userId,
      title: 'SMS',
      body: message,
      type: 'SMS',
    });

    this.logger.log(`Sending SMS to user ${userId}: ${message}`);
    return notification;
  }

  async sendEmail(userId: string, subject: string, body: string) {
    const notification = await this.notificationsRepo.create({
      userId,
      title: subject,
      body,
      type: 'EMAIL',
    });

    this.logger.log(`Sending Email to user ${userId}: ${subject}`);
    return notification;
  }

  async getMyNotifications(userId: string, query: PaginationDto) {
    const skip = (query.page - 1) * query.limit;
    const [items, total] = await Promise.all([
      this.notificationsRepo.findByUserId(userId, skip, query.limit),
      this.notificationsRepo.countByUserId(userId),
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

  async markAsRead(notificationId: string, userId: string) {
    await this.notificationsRepo.markAsRead(notificationId, userId);
  }

  async markAllAsRead(userId: string) {
    await this.notificationsRepo.markAllAsRead(userId);
  }

  async getUnreadCount(userId: string) {
    return this.notificationsRepo.getUnreadCount(userId);
  }
}
