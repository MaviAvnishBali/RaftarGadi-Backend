import { Module } from '@nestjs/common';
import { NotificationsController } from './controllers/notifications.controller';
import { NotificationsService } from './services/notifications.service';
import { NotificationsRepository } from './repositories/notifications.repository';
import { FcmService } from './services/fcm.service';
import { BullModule } from '@nestjs/bullmq';

@Module({
  imports: [
    BullModule.registerQueue({
      name: 'notification-queue',
    }),
  ],
  controllers: [NotificationsController],
  providers: [NotificationsService, NotificationsRepository, FcmService],
  exports: [NotificationsService],
})
export class NotificationsModule {}
