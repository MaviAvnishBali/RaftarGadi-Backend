import { Module } from '@nestjs/common';
import { SupportController } from './controllers/support.controller';
import { SupportService } from './services/support.service';
import { SupportRepository } from './repositories/support.repository';

@Module({
  controllers: [SupportController],
  providers: [SupportService, SupportRepository],
  exports: [SupportService],
})
export class SupportModule {}
