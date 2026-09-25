import { Processor, WorkerHost } from '@nestjs/bullmq';
import { Logger } from '@nestjs/common';
import { Job } from 'bullmq';
import { QUEUE_NAMES } from '../constants';

@Processor(QUEUE_NAMES.CLEANUP, {
  concurrency: 1,
})
export class CleanupProcessor extends WorkerHost {
  private readonly logger = new Logger(CleanupProcessor.name);

  async process(job: Job): Promise<void> {
    this.logger.log(`Processing cleanup job ${job.id}: ${job.name}`);

    try {
      this.logger.log(`Executing cleanup tasks...`);
      await this.delay(1000);
      this.logger.log(`Cleanup completed successfully: ${job.id}`);
    } catch (error) {
      this.logger.error(`Failed to execute cleanup: ${job.id}`, error);
      throw error;
    }
  }

  private delay(ms: number): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }
}
