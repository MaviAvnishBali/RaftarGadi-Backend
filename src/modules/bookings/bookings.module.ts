import { Module } from '@nestjs/common';
import { BookingsController } from './controllers/bookings.controller';
import { BookingsService } from './services/bookings.service';
import { BookingStateMachineService } from './services/booking-state-machine.service';
import { DriverMatchingService } from './services/driver-matching.service';
import { BookingsRepository } from './repositories/bookings.repository';

@Module({
  imports: [],
  controllers: [BookingsController],
  providers: [
    BookingsService,
    BookingStateMachineService,
    DriverMatchingService,
    BookingsRepository,
  ],
  exports: [BookingsService],
})
export class BookingsModule {}
