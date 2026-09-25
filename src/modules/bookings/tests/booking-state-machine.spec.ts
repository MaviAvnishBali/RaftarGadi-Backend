import { Test, TestingModule } from '@nestjs/testing';
import { BookingStateMachineService } from '../services/booking-state-machine.service';
import { AppException } from '../../../common/exceptions/app.exception';

describe('BookingStateMachineService', () => {
  let service: BookingStateMachineService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [BookingStateMachineService],
    }).compile();

    service = module.get<BookingStateMachineService>(BookingStateMachineService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('canTransition', () => {
    it('should return true for valid transitions', () => {
      expect(service.canTransition('REQUESTED', 'SEARCHING_DRIVER')).toBe(true);
      expect(service.canTransition('SEARCHING_DRIVER', 'DRIVER_ASSIGNED')).toBe(true);
      expect(service.canTransition('TRIP_STARTED', 'TRIP_COMPLETED')).toBe(true);
      expect(service.canTransition('REQUESTED', 'CANCELLED')).toBe(true);
    });

    it('should return false for invalid transitions', () => {
      expect(service.canTransition('REQUESTED', 'TRIP_STARTED')).toBe(false);
      expect(service.canTransition('COMPLETED', 'REQUESTED')).toBe(false);
      expect(service.canTransition('INVALID_STATUS', 'REQUESTED')).toBe(false);
    });

    it('should return false for terminal states', () => {
      expect(service.canTransition('COMPLETED', 'SEARCHING_DRIVER')).toBe(false);
      expect(service.canTransition('CANCELLED', 'SEARCHING_DRIVER')).toBe(false);
    });
  });

  describe('validateTransition', () => {
    it('should not throw for valid transitions', () => {
      expect(() => service.validateTransition('REQUESTED', 'SEARCHING_DRIVER')).not.toThrow();
    });

    it('should throw AppException for invalid transitions', () => {
      expect(() => service.validateTransition('REQUESTED', 'TRIP_STARTED')).toThrow(AppException);
    });
  });

  describe('isCancellable', () => {
    it('should return true for cancellable statuses', () => {
      expect(service.isCancellable('REQUESTED')).toBe(true);
      expect(service.isCancellable('SEARCHING_DRIVER')).toBe(true);
      expect(service.isCancellable('DRIVER_ASSIGNED')).toBe(true);
      expect(service.isCancellable('DRIVER_ARRIVING')).toBe(true);
      expect(service.isCancellable('DRIVER_ARRIVED')).toBe(true);
    });

    it('should return false for non-cancellable statuses', () => {
      expect(service.isCancellable('TRIP_STARTED')).toBe(false);
      expect(service.isCancellable('TRIP_COMPLETED')).toBe(false);
      expect(service.isCancellable('COMPLETED')).toBe(false);
      expect(service.isCancellable('CANCELLED')).toBe(false);
      expect(service.isCancellable('PAYMENT_PENDING')).toBe(false);
    });
  });
});
