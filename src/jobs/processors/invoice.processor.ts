import { Processor, WorkerHost } from '@nestjs/bullmq';
import { Logger } from '@nestjs/common';
import { Job } from 'bullmq';
import { QUEUE_NAMES } from '../constants';

@Processor(QUEUE_NAMES.INVOICE, {
  concurrency: 2,
})
export class InvoiceProcessor extends WorkerHost {
  private readonly logger = new Logger(InvoiceProcessor.name);

  async process(job: Job): Promise<void> {
    this.logger.log(`Processing invoice job ${job.id}: ${job.name}`);
    const { bookingId, amount, customerId } = job.data;

    try {
      this.logger.log(`Generating invoice for booking ${bookingId}`);
      await this.delay(500);
      this.logger.log(`Invoice generated successfully: ${job.id}`);
    } catch (error) {
      this.logger.error(`Failed to generate invoice: ${job.id}`, error);
      throw error;
    }
  }

  private delay(ms: number): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }
}
