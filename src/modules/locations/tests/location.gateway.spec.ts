import { Test, TestingModule } from '@nestjs/testing';
import { LocationGateway } from '../gateways/location.gateway';
import { LocationsService } from '../services/locations.service';
import { JwtService } from '@nestjs/jwt';
import { RedisService } from '../../../config/redis.service';
import { PrismaService } from '../../../database/prisma.service';

describe('LocationGateway', () => {
  let gateway: LocationGateway;
  let locationsService: any;
  let prisma: any;
  let server: any;

  beforeEach(async () => {
    locationsService = {
      updateDriverLocation: jest.fn(),
      saveBookingLocation: jest.fn(),
      findNearbyDrivers: jest.fn(),
      removeDriverLocation: jest.fn(),
    };

    prisma = {
      driver: {
        findUnique: jest.fn(),
        findMany: jest.fn(),
      },
      booking: {
        findUnique: jest.fn(),
      },
    };

    server = {
      emit: jest.fn(),
      to: jest.fn().mockReturnThis(),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        LocationGateway,
        { provide: LocationsService, useValue: locationsService },
        { provide: JwtService, useValue: {} },
        { provide: RedisService, useValue: { client: { set: jest.fn(), get: jest.fn(), del: jest.fn() } } },
        { provide: PrismaService, useValue: prisma },
      ],
    }).compile();

    gateway = module.get<LocationGateway>(LocationGateway);
    gateway.server = server;
  });

  it('should be defined', () => {
    expect(gateway).toBeDefined();
  });

  describe('handleLocationUpdate', () => {
    it('should reject invalid coordinates', async () => {
      const client: any = {
        data: {
          user: { sub: 'driver-user-1', role: 'DRIVER' },
          driverId: 'driver-1',
        },
      };

      await gateway.handleLocationUpdate(client, {
        latitude: 999.0, // Invalid lat > 90
        longitude: 77.2,
      });

      expect(locationsService.updateDriverLocation).not.toHaveBeenCalled();
    });

    it('should update location and stream to active booking room', async () => {
      const client: any = {
        data: {
          user: { sub: 'driver-user-1', role: 'DRIVER' },
          driverId: 'driver-1',
        },
      };

      prisma.booking.findUnique.mockResolvedValue({
        id: 'booking-1',
        driverId: 'driver-1',
        status: 'TRIP_STARTED',
      });

      await gateway.handleLocationUpdate(client, {
        latitude: 28.6139,
        longitude: 77.2090,
        heading: 90,
        speed: 35,
        bookingId: 'booking-1',
      });

      expect(locationsService.updateDriverLocation).toHaveBeenCalledWith(
        'driver-1',
        28.6139,
        77.2090,
        90,
        35,
      );
      expect(locationsService.saveBookingLocation).toHaveBeenCalledWith(
        'booking-1',
        28.6139,
        77.2090,
        90,
        35,
      );
      expect(server.to).toHaveBeenCalledWith('booking:booking-1');
      expect(server.emit).toHaveBeenCalledWith(
        'driver:location',
        expect.objectContaining({
          bookingId: 'booking-1',
          driverId: 'driver-1',
          latitude: 28.6139,
          longitude: 77.2090,
        }),
      );
    });
  });

  describe('handleBookingAssigned', () => {
    it('should broadcast booking:taken to all connected drivers', () => {
      gateway.handleBookingAssigned({
        bookingId: 'booking-abc',
        assignedDriverId: 'driver-xyz',
        status: 'DRIVER_ARRIVING',
      });

      expect(server.emit).toHaveBeenCalledWith('booking:taken', {
        bookingId: 'booking-abc',
        assignedDriverId: 'driver-xyz',
        status: 'DRIVER_ARRIVING',
      });
    });
  });

  describe('handleBookingJoin', () => {
    it('should reject unauthorized user attempting to join a booking room', async () => {
      const client: any = {
        data: {
          user: { sub: 'unauthorized-user', role: 'CUSTOMER' },
        },
        join: jest.fn(),
        emit: jest.fn(),
      };

      prisma.booking.findUnique.mockResolvedValue({
        id: 'booking-secret',
        customer: { userId: 'real-customer-user' },
        driver: { userId: 'real-driver-user' },
      });

      await gateway.handleBookingJoin(client, { bookingId: 'booking-secret' });

      expect(client.join).not.toHaveBeenCalled();
      expect(client.emit).toHaveBeenCalledWith('error', expect.objectContaining({ message: expect.any(String) }));
    });
  });
});
