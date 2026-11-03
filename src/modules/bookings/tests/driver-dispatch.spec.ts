import { Test, TestingModule } from '@nestjs/testing';
import { BookingsService } from '../services/bookings.service';
import { BookingsRepository } from '../repositories/bookings.repository';
import { BookingStateMachineService } from '../services/booking-state-machine.service';
import { PrismaService } from '../../../database/prisma.service';
import { RedisService } from '../../../config/redis.service';
import { EventEmitter2 } from '@nestjs/event-emitter';
import { AppException } from '../../../common/exceptions/app.exception';

describe('Driver Dispatch & First-to-Accept Logic', () => {
  let service: BookingsService;
  let prisma: any;
  let eventEmitter: any;

  beforeEach(async () => {
    prisma = {
      driver: {
        findUnique: jest.fn(),
        update: jest.fn(),
      },
      booking: {
        findUnique: jest.fn(),
        findFirst: jest.fn(),
        update: jest.fn(),
        updateMany: jest.fn(),
      },
      bookingStatusHistory: {
        create: jest.fn(),
      },
      $transaction: jest.fn((cb) => cb(prisma)),
    };

    eventEmitter = {
      emit: jest.fn(),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        BookingsService,
        { provide: BookingsRepository, useValue: {} },
        { provide: BookingStateMachineService, useValue: {} },
        { provide: PrismaService, useValue: prisma },
        { provide: RedisService, useValue: { client: { set: jest.fn() } } },
        { provide: EventEmitter2, useValue: eventEmitter },
      ],
    }).compile();

    service = module.get<BookingsService>(BookingsService);
  });

  it('should successfully assign driver when booking is REQUESTED and unassigned', async () => {
    prisma.driver.findUnique.mockResolvedValue({
      id: 'driver-1',
      userId: 'user-driver-1',
      status: 'ONLINE',
      isAvailable: true,
      vehicle: { id: 'vehicle-1', vehicleTypeId: 'vt-1' },
    });

    prisma.booking.findFirst.mockResolvedValue(null); // No active trip

    prisma.booking.findUnique.mockResolvedValue({
      id: 'booking-1',
      status: 'REQUESTED',
      driverId: null,
    });

    prisma.booking.updateMany.mockResolvedValue({ count: 1 });

    const result = await service.driverAcceptBooking('booking-1', 'user-driver-1');

    expect(result).toBeDefined();
    expect(prisma.booking.updateMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: expect.objectContaining({ id: 'booking-1', driverId: null }),
        data: expect.objectContaining({
          status: 'DRIVER_ARRIVING',
          driverId: 'driver-1',
        }),
      }),
    );
    expect(eventEmitter.emit).toHaveBeenCalledWith(
      'booking.assigned',
      expect.objectContaining({
        bookingId: 'booking-1',
        assignedDriverId: 'driver-1',
      }),
    );
  });

  it('should reject with 409 conflict when another driver has already accepted the booking', async () => {
    prisma.driver.findUnique.mockResolvedValue({
      id: 'driver-2',
      userId: 'user-driver-2',
      status: 'ONLINE',
      isAvailable: true,
      vehicle: { id: 'vehicle-2', vehicleTypeId: 'vt-1' },
    });

    prisma.booking.findFirst.mockResolvedValue(null);

    // Booking is ALREADY claimed by driver-1
    prisma.booking.findUnique.mockResolvedValue({
      id: 'booking-1',
      status: 'DRIVER_ARRIVING',
      driverId: 'driver-1',
    });

    await expect(service.driverAcceptBooking('booking-1', 'user-driver-2')).rejects.toThrow(
      AppException,
    );

    try {
      await service.driverAcceptBooking('booking-1', 'user-driver-2');
    } catch (err: any) {
      expect(err.getStatus()).toBe(409);
      expect(err.message).toBe('This ride was already accepted by another driver');
    }
  });

  it('should reject when driver already has an active trip in progress', async () => {
    prisma.driver.findUnique.mockResolvedValue({
      id: 'driver-busy',
      userId: 'user-driver-busy',
      status: 'ONLINE',
      isAvailable: true,
      vehicle: { id: 'vehicle-busy' },
    });

    // Driver already has an ongoing trip
    prisma.booking.findFirst.mockResolvedValue({
      id: 'existing-trip',
      status: 'TRIP_STARTED',
      driverId: 'driver-busy',
    });

    await expect(service.driverAcceptBooking('booking-2', 'user-driver-busy')).rejects.toThrow(
      AppException,
    );

    try {
      await service.driverAcceptBooking('booking-2', 'user-driver-busy');
    } catch (err: any) {
      expect(err.getStatus()).toBe(409);
      expect(err.message).toContain('active delivery');
    }
  });

  it('should auto-expire stale bookings older than threshold', async () => {
    prisma.booking.findMany = jest.fn().mockResolvedValue([
      { id: 'stale-1', bookingNumber: 'BK-STALE1', status: 'REQUESTED' },
    ]);
    jest.spyOn(service, 'cancelBooking').mockResolvedValue({} as any);

    const count = await service.expireStaleRequestedBookings(90);

    expect(count).toBe(1);
    expect(service.cancelBooking).toHaveBeenCalledWith(
      'stale-1',
      'SYSTEM',
      'SYSTEM',
      expect.stringContaining('Dispatch timed out'),
    );
  });
});
