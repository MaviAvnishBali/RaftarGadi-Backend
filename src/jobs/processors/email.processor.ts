import { Processor, WorkerHost } from '@nestjs/bullmq';
import { Logger } from '@nestjs/common';
import { Job } from 'bullmq';
import { QUEUE_NAMES } from '../constants';

@Processor(QUEUE_NAMES.EMAIL, {
  concurrency: 3,
})
export class EmailProcessor extends WorkerHost {
  private readonly logger = new Logger(EmailProcessor.name);

  async process(job: Job): Promise<void> {
    this.logger.log(`Processing email job ${job.id}: ${job.name}`);
    const { to, subject, template, context } = job.data;

    try {
      this.logger.log(`Sending email to ${to} with subject: ${subject}`);
      await this.delay(200);
      this.logger.log(`Email sent successfully: ${job.id}`);
    } catch (error) {
      this.logger.error(`Failed to send email: ${job.id}`, error);
      throw error;
    }
  }

  private delay(ms: number): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }
}
