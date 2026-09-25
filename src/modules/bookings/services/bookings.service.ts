import { Injectable, Logger } from '@nestjs/common';
import { EventEmitter2 } from '@nestjs/event-emitter';
import { BookingsRepository } from '../repositories/bookings.repository';
import { BookingStateMachineService } from './booking-state-machine.service';
import { CreateBookingDto } from '../dto/create-booking.dto';
import { BookingQueryDto } from '../dto/booking-query.dto';
import { AdminBookingQueryDto } from '../dto/admin-booking-query.dto';
import { PaginatedResponse } from '../../../common/dto/pagination.dto';
import { AppException } from '../../../common/exceptions/app.exception';
import { PrismaService } from '../../../database/prisma.service';
import { BookingStatus } from '@prisma/client';
import {
  BookingCreatedEvent,
  BookingDriverAssignedEvent,
  BookingTripStartedEvent,
  BookingTripCompletedEvent,
  BookingCancelledEvent,
} from '../events/booking.events';

@Injectable()
export class BookingsService {
  private readonly logger = new Logger(BookingsService.name);

  constructor(
    private readonly bookingsRepo: BookingsRepository,
    private readonly stateMachine: BookingStateMachineService,
    private readonly prisma: PrismaService,
    private readonly eventEmitter: EventEmitter2,
  ) {}

  private generateBookingNumber(): string {
    const randomChars = Math.random().toString(36).substring(2, 8).toUpperCase();
    return `BK-${randomChars}`;
  }

  async createBooking(
    customerId: string,
    dto: CreateBookingDto,
    idempotencyKey?: string,
  ): Promise<unknown> {
    if (idempotencyKey) {
      const existing = await this.prisma.booking.findFirst({
        where: { idempotencyKey },
      });
      if (existing) return existing;
    }

    const bookingNumber = this.generateBookingNumber();

    const booking = await this.prisma.$transaction(async (tx) => {
      const created = await tx.booking.create({
        data: {
          bookingNumber,
          customer: { connect: { id: customerId } },
          vehicleType: { connect: { id: dto.vehicleTypeId } },
          pickupLat: dto.pickupLat,
          pickupLng: dto.pickupLng,
          pickupAddress: dto.pickupAddress,
          dropLat: dto.dropLat,
          dropLng: dto.dropLng,
          dropAddress: dto.dropAddress,
          packageType: dto.packageType,
          packageDescription: dto.packageDescription,
          packageWeightKg: dto.packageWeightKg,
          status: 'REQUESTED',
          paymentStatus: 'PENDING',
          idempotencyKey,
        },
      });

      await tx.bookingStatusHistory.create({
        data: {
          bookingId: created.id,
          newStatus: 'REQUESTED',
          changedBy: customerId,
        },
      });

      return created;
    });

    this.eventEmitter.emit(
      'booking.created',
      new BookingCreatedEvent(booking.id, customerId, dto.vehicleTypeId),
    );

    return booking;
  }

  async findById(id: string): Promise<unknown> {
    const booking = await this.bookingsRepo.findById(id);
    if (!booking) throw AppException.bookingNotFound();
    return booking;
  }

  async findByBookingNumber(bookingNumber: string): Promise<unknown> {
    const booking = await this.bookingsRepo.findByBookingNumber(bookingNumber);
    if (!booking) throw AppException.bookingNotFound();
    return booking;
  }

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  private buildWhereClause(
    query: BookingQueryDto | AdminBookingQueryDto,
    baseWhere: any = {},
  ): any {
    const where = { ...baseWhere };
    if (query.status) where.status = query.status;
    if (query.from && query.to) {
      where.createdAt = { gte: new Date(query.from), lte: new Date(query.to) };
    } else if (query.from) {
      where.createdAt = { gte: new Date(query.from) };
    } else if (query.to) {
      where.createdAt = { lte: new Date(query.to) };
    }
    return where;
  }

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  async getCustomerBookings(
    customerId: string,
    query: BookingQueryDto,
  ): Promise<PaginatedResponse<any>> {
    const where = this.buildWhereClause(query, { customerId });
    const skip = (query.page - 1) * query.limit;
    const [data, total] = await Promise.all([
      this.bookingsRepo.findMany({
        where,
        skip,
        take: query.limit,
        orderBy: { createdAt: 'desc' },
      }),
      this.bookingsRepo.count({ where }),
    ]);

    return new PaginatedResponse(data, total, query.page, query.limit);
  }

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  async getDriverBookings(
    driverId: string,
    query: BookingQueryDto,
  ): Promise<PaginatedResponse<any>> {
    const where = this.buildWhereClause(query, { driverId });
    const skip = (query.page - 1) * query.limit;
    const [data, total] = await Promise.all([
      this.bookingsRepo.findMany({
        where,
        skip,
        take: query.limit,
        orderBy: { createdAt: 'desc' },
      }),
      this.bookingsRepo.count({ where }),
    ]);

    return new PaginatedResponse(data, total, query.page, query.limit);
  }

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  async getAllBookings(query: AdminBookingQueryDto): Promise<PaginatedResponse<any>> {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const baseWhere: any = {};
    if ('customerId' in query && query.customerId) baseWhere.customerId = query.customerId;
    if ('driverId' in query && query.driverId) baseWhere.driverId = query.driverId;
    if ('paymentStatus' in query && query.paymentStatus)
      baseWhere.paymentStatus = query.paymentStatus;
    if ('search' in query && query.search) {
      baseWhere.OR = [{ bookingNumber: { contains: query.search, mode: 'insensitive' } }];
    }
    const where = this.buildWhereClause(query, baseWhere);

    const skip = (query.page - 1) * query.limit;
    const [data, total] = await Promise.all([
      this.bookingsRepo.findMany({
        where,
        skip,
        take: query.limit,
        orderBy: { createdAt: 'desc' },
      }),
      this.bookingsRepo.count({ where }),
    ]);

    return new PaginatedResponse(data, total, query.page, query.limit);
  }

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  async transitionStatus(
    bookingId: string,
    targetStatus: string,
    changedBy: string,
    reason?: string,
    metadata?: any,
  ): Promise<unknown> {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const booking = (await this.findById(bookingId)) as any;
    this.stateMachine.validateTransition(booking.status, targetStatus);

    const updated = await this.prisma.$transaction(async (tx) => {
      const result = await tx.booking.update({
        where: { id: bookingId },
        data: {
          status: targetStatus as BookingStatus,
        },
        include: {
          customer: true,
          driver: true,
          vehicleType: true,
        },
      });

      await tx.bookingStatusHistory.create({
        data: {
          bookingId,
          oldStatus: booking.status,
          newStatus: targetStatus as BookingStatus,
          changedBy,
          reason,
          metadata: metadata || undefined,
        },
      });

      return result;
    });

    return updated;
  }

  async assignDriver(bookingId: string, driverId: string, vehicleId: string): Promise<unknown> {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const booking = (await this.findById(bookingId)) as any;
    this.stateMachine.validateTransition(booking.status, 'DRIVER_ASSIGNED');

    const updated = await this.prisma.$transaction(async (tx) => {
      const result = await tx.booking.update({
        where: { id: bookingId },
        data: {
          status: 'DRIVER_ASSIGNED',
          driverId,
          vehicleId,
          driverAssignedAt: new Date(),
        },
      });

      await tx.bookingStatusHistory.create({
        data: {
          bookingId,
          oldStatus: booking.status,
          newStatus: 'DRIVER_ASSIGNED',
          changedBy: 'SYSTEM',
          reason: 'Driver assigned',
        },
      });

      return result;
    });

    this.eventEmitter.emit(
      'booking.driver_assigned',
      new BookingDriverAssignedEvent(bookingId, driverId),
    );
    return updated;
  }

  async cancelBooking(
    bookingId: string,
    cancelledBy: string,
    cancelledByType: string,
    reason?: string,
  ): Promise<unknown> {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const booking = (await this.findById(bookingId)) as any;
    if (!this.stateMachine.isCancellable(booking.status)) {
      throw AppException.bookingInvalidState(booking.status, 'CANCELLED');
    }

    const updated = await this.transitionStatus(bookingId, 'CANCELLED', cancelledBy, reason);

    this.eventEmitter.emit(
      'booking.cancelled',
      new BookingCancelledEvent(bookingId, cancelledBy, reason),
    );
    return updated;
  }

  async startTrip(bookingId: string, driverId: string): Promise<unknown> {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const booking = (await this.findById(bookingId)) as any;
    if (booking.driverId !== driverId) throw AppException.forbidden();

    this.stateMachine.validateTransition(booking.status, 'TRIP_STARTED');

    const updated = await this.prisma.$transaction(async (tx) => {
      const result = await tx.booking.update({
        where: { id: bookingId },
        data: {
          status: 'TRIP_STARTED',
          tripStartedAt: new Date(),
        },
      });

      await tx.bookingStatusHistory.create({
        data: {
          bookingId,
          oldStatus: booking.status,
          newStatus: 'TRIP_STARTED',
          changedBy: driverId,
        },
      });

      return result;
    });

    this.eventEmitter.emit('booking.trip_started', new BookingTripStartedEvent(bookingId));
    return updated;
  }

  async completeTrip(
    bookingId: string,
    driverId: string,
    actualDistanceKm: number,
    actualDurationMin: number,
  ): Promise<unknown> {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const booking = (await this.findById(bookingId)) as any;
    if (booking.driverId !== driverId) throw AppException.forbidden();

    this.stateMachine.validateTransition(booking.status, 'TRIP_COMPLETED');

    const finalFare = booking.estimatedFare || actualDistanceKm * 15 + actualDurationMin * 2;

    const updated = await this.prisma.$transaction(async (tx) => {
      const result = await tx.booking.update({
        where: { id: bookingId },
        data: {
          status: 'TRIP_COMPLETED',
          tripCompletedAt: new Date(),
          actualDistanceKm,
          actualDurationMin,
          finalFare,
        },
      });

      await tx.bookingStatusHistory.create({
        data: {
          bookingId,
          oldStatus: booking.status,
          newStatus: 'TRIP_COMPLETED',
          changedBy: driverId,
        },
      });

      return result;
    });

    this.eventEmitter.emit(
      'booking.trip_completed',
      new BookingTripCompletedEvent(bookingId, finalFare),
    );
    return updated;
  }

  async getBookingStats(): Promise<Record<string, number>> {
    const stats = await this.prisma.booking.groupBy({
      by: ['status'],
      _count: {
        id: true,
      },
    });

    return stats.reduce(
      (acc, curr) => {
        acc[curr.status] = curr._count.id;
        return acc;
      },
      {} as Record<string, number>,
    );
  }
}
