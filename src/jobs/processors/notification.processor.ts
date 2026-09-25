import { Processor, WorkerHost } from '@nestjs/bullmq';
import { Logger } from '@nestjs/common';
import { Job } from 'bullmq';
import { QUEUE_NAMES } from '../constants';

@Processor(QUEUE_NAMES.NOTIFICATION, {
  concurrency: 5,
})
export class NotificationProcessor extends WorkerHost {
  private readonly logger = new Logger(NotificationProcessor.name);

  async process(job: Job): Promise<void> {
    this.logger.log(`Processing notification job ${job.id}: ${job.name}`);
    const { userId, title, body, channel, metadata } = job.data;

    try {
      // In production, integrate with FCM/SMS/Email providers
      this.logger.log(`Sending ${channel} notification to user ${userId}: ${title}`);
      // Mock: log and succeed
      await this.delay(100); // simulate network call
      this.logger.log(`Notification sent successfully: ${job.id}`);
    } catch (error) {
      this.logger.error(`Failed to send notification: ${job.id}`, error);
      throw error; // BullMQ will retry based on config
    }
  }

  private delay(ms: number): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }
}
