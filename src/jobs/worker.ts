import { NestFactory } from '@nestjs/core';
import { Logger } from '@nestjs/common';
import { AppModule } from '../app.module';

async function bootstrap() {
  const app = await NestFactory.createApplicationContext(AppModule);
  const logger = new Logger('Worker');
  logger.log('BullMQ Worker started');

  // Keep the process running
  process.on('SIGTERM', async () => {
    logger.log('Worker shutting down...');
    await app.close();
    process.exit(0);
  });
}

bootstrap();
