import { Module } from '@nestjs/common';
import { BullModule } from '@nestjs/bullmq';
import { ConfigService } from '@nestjs/config';
import { NotificationProcessor } from './processors/notification.processor';
import { EmailProcessor } from './processors/email.processor';
import { InvoiceProcessor } from './processors/invoice.processor';
import { CleanupProcessor } from './processors/cleanup.processor';
import { QUEUE_NAMES } from './constants';

@Module({
  imports: [
    BullModule.forRootAsync({
      useFactory: (configService: ConfigService) => ({
        connection: {
          host: configService.get('REDIS_HOST', 'localhost'),
          port: configService.get('REDIS_PORT', 6379),
          password: configService.get('REDIS_PASSWORD') || undefined,
        },
      }),
      inject: [ConfigService],
    }),
    BullModule.registerQueue(
      { name: QUEUE_NAMES.NOTIFICATION },
      { name: QUEUE_NAMES.EMAIL },
      { name: QUEUE_NAMES.SMS },
      { name: QUEUE_NAMES.INVOICE },
      { name: QUEUE_NAMES.ANALYTICS },
      { name: QUEUE_NAMES.CLEANUP },
    ),
  ],
  providers: [NotificationProcessor, EmailProcessor, InvoiceProcessor, CleanupProcessor],
  exports: [BullModule],
})
export class JobsModule {}
