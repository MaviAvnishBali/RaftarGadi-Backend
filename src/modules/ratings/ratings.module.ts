import { Module } from '@nestjs/common';
import { RatingsController } from './controllers/ratings.controller';
import { RatingsService } from './services/ratings.service';
import { RatingsRepository } from './repositories/ratings.repository';

@Module({
  controllers: [RatingsController],
  providers: [RatingsService, RatingsRepository],
  exports: [RatingsService],
})
export class RatingsModule {}
