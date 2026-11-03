import { Injectable, Logger, HttpStatus, Optional, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { EventEmitter2 } from '@nestjs/event-emitter';
import { BookingsRepository } from '../repositories/bookings.repository';
import { BookingStateMachineService } from './booking-state-machine.service';
import { CreateBookingDto } from '../dto/create-booking.dto';
import { BookingQueryDto } from '../dto/booking-query.dto';
import { AdminBookingQueryDto } from '../dto/admin-booking-query.dto';
import { PaginatedResponse } from '../../../common/dto/pagination.dto';
import { AppException } from '../../../common/exceptions/app.exception';
import { PrismaService } from '../../../database/prisma.service';
import { RedisService } from '../../../config/redis.service';
import { ServiceableAreasService } from '../../serviceable-areas/services/serviceable-areas.service';
import { BookingStatus } from '@prisma/client';
import { Role } from '../../../common/enums';
import {
  BookingCreatedEvent,
  BookingDriverAssignedEvent,
  BookingTripStartedEvent,
  BookingTripCompletedEvent,
  BookingCancelledEvent,
} from '../events/booking.events';

@Injectable()
export class BookingsService implements OnModuleInit, OnModuleDestroy {
  private readonly logger = new Logger(BookingsService.name);
  private expiryInterval?: NodeJS.Timeout;

  constructor(
    private readonly bookingsRepo: BookingsRepository,
    private readonly stateMachine: BookingStateMachineService,
    private readonly prisma: PrismaService,
    private readonly eventEmitter: EventEmitter2,
    private readonly redisService: RedisService,
    @Optional() private readonly serviceableAreasService?: ServiceableAreasService,
  ) {}

  async onModuleInit(): Promise<void> {
    // Immediate startup sweep to expire any lingering stale test bookings
    this.expireStaleRequestedBookings(300).catch((err) =>
      this.logger.warn(`Startup stale booking sweep error: ${err}`),
    );

    // Periodic sweep every 15 seconds
    this.expiryInterval = setInterval(() => {
      this.expireStaleRequestedBookings(300).catch((err) =>
        this.logger.warn(`Periodic stale booking sweep error: ${err}`),
      );
    }, 15000);
  }

  onModuleDestroy(): void {
    if (this.expiryInterval) {
      clearInterval(this.expiryInterval);
    }
  }

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

    // Strictly validate that customer pickup point falls within an active operational area
    if (this.serviceableAreasService && typeof dto.pickupLat === 'number' && typeof dto.pickupLng === 'number') {
      await this.serviceableAreasService.validateServiceability(
        dto.pickupLat,
        dto.pickupLng,
        dto.pickupAddress,
        'pickup',
      );
    }

    // Strictly validate that customer drop point falls within an active operational area
    if (this.serviceableAreasService && typeof dto.dropLat === 'number' && typeof dto.dropLng === 'number') {
      await this.serviceableAreasService.validateServiceability(
        dto.dropLat,
        dto.dropLng,
        dto.dropAddress,
        'drop',
      );
    }

    const bookingNumber = this.generateBookingNumber();

    let customer = await this.prisma.customer.findFirst({
      where: { OR: [{ id: customerId }, { userId: customerId }] },
    });
    if (!customer) {
      const user = await this.prisma.user.findUnique({
        where: { id: customerId },
      });
      if (user) {
        customer = await this.prisma.customer.create({
          data: { userId: user.id },
        });
      }
    }
    const effectiveCustomerId = customer ? customer.id : customerId;

    let vehicleTypeId = dto.vehicleTypeId;
    if (!vehicleTypeId || !vehicleTypeId.includes('-')) {
      const vName = (dto.vehicleType || dto.vehicleTypeId || 'bike').toLowerCase();
      const allTypes = await this.prisma.vehicleType.findMany();
      const matched = allTypes.find((vt) => {
        const n = vt.name.toLowerCase();
        if (vName.includes('bike') && (n.includes('bike') || n.includes('2-wheeler'))) return true;
        if (vName.includes('auto') && (n.includes('3-wheeler') || n.includes('auto'))) return true;
        if (vName.includes('mini') && (n.includes('tata ace') || n.includes('chota'))) return true;
        if (vName.includes('truck') && (n.includes('407') || n.includes('bolero') || n.includes('truck'))) return true;
        return n.includes(vName);
      });
      vehicleTypeId = matched ? matched.id : allTypes[0]?.id;
    }

    const booking = await this.prisma.$transaction(async (tx) => {
      const created = await tx.booking.create({
        data: {
          bookingNumber,
          customer: { connect: { id: effectiveCustomerId } },
          vehicleType: { connect: { id: vehicleTypeId } },
          pickupLat: dto.pickupLat,
          pickupLng: dto.pickupLng,
          pickupAddress: dto.pickupAddress,
          dropLat: dto.dropLat,
          dropLng: dto.dropLng,
          dropAddress: dto.dropAddress,
          packageType: dto.packageType,
          packageDescription: dto.packageDescription,
          packageWeightKg: dto.packageWeightKg,
          estimatedFare: dto.estimatedFare,
          estimatedDistanceKm: dto.estimatedDistanceKm,
          estimatedDurationMin: dto.estimatedDurationMin,
          status: 'REQUESTED',
          paymentStatus: 'PENDING',
          idempotencyKey,
        },
        include: {
          customer: { include: { user: true } },
          vehicleType: true,
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

    const startOtp = Math.floor(1000 + Math.random() * 9000).toString();
    try {
      await this.redisService.client.set(
        `booking:${booking.id}:start_otp`,
        startOtp,
        'EX',
        86400,
      );
    } catch (err) {
      this.logger.warn(`Failed to store start OTP in Redis: ${err}`);
    }

    this.eventEmitter.emit(
      'booking.created',
      {
        ...booking,
        startOtp,
      },
    );

    return {
      ...booking,
      startOtp,
    };
  }

  async findById(id: string): Promise<unknown> {
    const booking = (await this.bookingsRepo.findById(id)) as any;
    if (!booking) throw AppException.bookingNotFound();
    try {
      const startOtp = await this.redisService.client.get(`booking:${id}:start_otp`);
      return {
        ...booking,
        startOtp: startOtp || '1234',
      };
    } catch (_) {
      return {
        ...booking,
        startOtp: '1234',
      };
    }
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
    if (query.status && query.status !== 'ALL') {
      const s = query.status.toUpperCase();
      if (s === 'IN_TRANSIT') {
        where.status = {
          in: ['DRIVER_ASSIGNED', 'DRIVER_ARRIVING', 'DRIVER_ARRIVED', 'TRIP_STARTED'],
        };
      } else if (s === 'PENDING') {
        where.status = {
          in: ['REQUESTED', 'SEARCHING_DRIVER'],
        };
      } else if (s === 'COMPLETED' || s === 'TRIP_COMPLETED') {
        where.status = {
          in: ['COMPLETED', 'TRIP_COMPLETED'],
        };
      } else {
        where.status = query.status;
      }
    }
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
    const customer = await this.prisma.customer.findFirst({
      where: { OR: [{ id: customerId }, { userId: customerId }] },
    });
    const effectiveCustomerId = customer ? customer.id : customerId;
    const where = this.buildWhereClause(query, { customerId: effectiveCustomerId });
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
    const driver = await this.prisma.driver.findFirst({
      where: { OR: [{ id: driverId }, { userId: driverId }] },
    });
    const effectiveDriverId = driver ? driver.id : driverId;
    const where = this.buildWhereClause(query, { driverId: effectiveDriverId });
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
    extraData?: Record<string, any>,
  ): Promise<unknown> {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const booking = (await this.findById(bookingId)) as any;
    this.stateMachine.validateTransition(booking.status, targetStatus);

    const updated = await this.prisma.$transaction(async (tx) => {
      const result = await tx.booking.update({
        where: { id: bookingId },
        data: {
          status: targetStatus as BookingStatus,
          ...(extraData || {}),
        },
        include: {
          customer: true,
          driver: true,
          vehicleType: true,
        },
      });

      const isValidUuid =
        typeof changedBy === 'string' &&
        /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(changedBy);

      await tx.bookingStatusHistory.create({
        data: {
          bookingId,
          oldStatus: booking.status,
          newStatus: targetStatus as BookingStatus,
          changedBy: isValidUuid ? changedBy : null,
          reason,
          metadata: metadata || undefined,
        },
      });

      return result;
    });

    this.eventEmitter.emit('booking.status', {
      bookingId,
      status: targetStatus,
      booking: updated,
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
          changedBy: null,
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
    const isAdmin =
      cancelledByType === Role.ADMIN ||
      cancelledByType === Role.SUPER_ADMIN ||
      cancelledByType === 'SYSTEM';
    if (isAdmin) {
      if (booking.status === 'COMPLETED' || booking.status === 'CANCELLED') {
        throw AppException.bookingInvalidState(booking.status, 'CANCELLED');
      }
    } else if (!this.stateMachine.isCancellable(booking.status)) {
      throw AppException.bookingInvalidState(booking.status, 'CANCELLED');
    }

    let parsedCancelledBy: 'CUSTOMER' | 'DRIVER' | 'ADMIN' | 'SYSTEM' = 'SYSTEM';
    if (cancelledByType === Role.CUSTOMER) parsedCancelledBy = 'CUSTOMER';
    else if (cancelledByType === Role.DRIVER) parsedCancelledBy = 'DRIVER';
    else if (cancelledByType === Role.ADMIN || cancelledByType === Role.SUPER_ADMIN)
      parsedCancelledBy = 'ADMIN';

    const updated = await this.transitionStatus(
      bookingId,
      'CANCELLED',
      cancelledBy,
      reason,
      undefined,
      {
        cancelledBy: parsedCancelledBy,
        cancellationReason: reason,
      },
    );

    this.eventEmitter.emit(
      'booking.cancelled',
      new BookingCancelledEvent(bookingId, cancelledBy, reason),
    );
    return updated;
  }

  async expireStaleRequestedBookings(maxAgeSeconds = 300): Promise<number> {
    const cutoffDate = new Date(Date.now() - maxAgeSeconds * 1000);
    const staleBookings = await this.prisma.booking.findMany({
      where: {
        status: { in: ['REQUESTED', 'SEARCHING_DRIVER'] },
        createdAt: { lt: cutoffDate },
      },
      select: {
        id: true,
        bookingNumber: true,
        status: true,
      },
      take: 100,
    });

    if (staleBookings.length === 0) {
      return 0;
    }

    this.logger.log(
      `Found ${staleBookings.length} stale requested bookings to expire (older than ${maxAgeSeconds}s)`,
    );

    let expiredCount = 0;
    for (const b of staleBookings) {
      try {
        await this.cancelBooking(
          b.id,
          'SYSTEM',
          'SYSTEM',
          'Dispatch timed out: No delivery partner accepted within dispatch window',
        );
        expiredCount++;
        this.logger.log(`Auto-expired stale booking ${b.bookingNumber} (${b.id})`);
      } catch (err) {
        this.logger.error(`Failed to auto-expire booking ${b.id}:`, err);
      }
    }

    return expiredCount;
  }

  async driverAcceptBooking(bookingId: string, userId: string): Promise<unknown> {
    const driver = await this.prisma.driver.findUnique({
      where: { userId },
      include: { vehicle: true },
    });
    if (!driver || !driver.vehicle) {
      throw new AppException('BAD_REQUEST', 'Driver must have a registered vehicle to accept orders', 400);
    }
    if (!driver.isAvailable || driver.status !== 'ONLINE') {
      throw new AppException('BAD_REQUEST', 'Driver is not available to accept orders', 400);
    }

    // Check if driver already has an active trip in progress
    const activeBooking = await this.prisma.booking.findFirst({
      where: {
        driverId: driver.id,
        status: { in: ['DRIVER_ASSIGNED', 'DRIVER_ARRIVING', 'DRIVER_ARRIVED', 'TRIP_STARTED'] },
      },
    });
    if (activeBooking) {
      throw new AppException('CONFLICT', 'Driver already has an active delivery in progress', HttpStatus.CONFLICT);
    }

    // Atomic assignment with database transaction using Compare-And-Swap (CAS)
    const updated = await this.prisma.$transaction(async (tx) => {
      const current = await tx.booking.findUnique({
        where: { id: bookingId },
      });
      if (!current) {
        throw new AppException('NOT_FOUND', 'Booking not found', HttpStatus.NOT_FOUND);
      }

      // Concurrency check: If already assigned or not in requestable state, reject with 409
      if (current.driverId != null || (current.status !== 'REQUESTED' && current.status !== 'SEARCHING_DRIVER')) {
        throw new AppException(
          'BOOKING_ALREADY_ACCEPTED',
          'This ride was already accepted by another driver',
          HttpStatus.CONFLICT,
        );
      }

      // Atomic Compare-And-Swap: guarantees only one driver can update the record
      const casResult = await tx.booking.updateMany({
        where: {
          id: bookingId,
          driverId: null,
          status: { in: ['REQUESTED', 'SEARCHING_DRIVER'] },
        },
        data: {
          status: 'DRIVER_ARRIVING',
          driverId: driver.id,
          vehicleId: driver.vehicle!.id,
          driverAssignedAt: new Date(),
        },
      });

      if (casResult.count === 0) {
        throw new AppException(
          'BOOKING_ALREADY_ACCEPTED',
          'This ride was already accepted by another driver',
          HttpStatus.CONFLICT,
        );
      }

      await tx.driver.update({
        where: { id: driver.id },
        data: { isAvailable: false },
      });

      await tx.bookingStatusHistory.create({
        data: {
          bookingId,
          oldStatus: current.status,
          newStatus: 'DRIVER_ARRIVING',
          changedBy: userId,
          reason: 'Driver accepted order',
        },
      });

      return tx.booking.findUnique({
        where: { id: bookingId },
        include: {
          customer: { include: { user: true } },
          vehicleType: true,
        },
      });
    });

    // 1. Emit status change for customer tracking
    this.eventEmitter.emit('booking.status', {
      bookingId,
      status: 'DRIVER_ARRIVING',
      booking: updated,
    });

    // 2. Emit assignment to broadcast booking:taken to all other drivers
    this.eventEmitter.emit('booking.assigned', {
      bookingId,
      assignedDriverId: driver.id,
      status: 'DRIVER_ARRIVING',
    });

    return updated;
  }

  async driverArrived(bookingId: string, userId: string): Promise<unknown> {
    const driver = await this.prisma.driver.findUnique({ where: { userId } });
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const booking = (await this.findById(bookingId)) as any;
    if (!booking) throw new AppException('NOT_FOUND', 'Booking not found', 404);
    if (driver && booking.driverId !== driver.id && booking.driverId !== userId) {
      throw AppException.forbidden();
    }

    return this.transitionStatus(bookingId, 'DRIVER_ARRIVED', userId, 'Driver arrived at pickup');
  }

  async startTrip(bookingId: string, userId: string, otp?: string): Promise<unknown> {
    const driver = await this.prisma.driver.findUnique({ where: { userId } });
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const booking = (await this.findById(bookingId)) as any;
    if (!booking) throw new AppException('NOT_FOUND', 'Booking not found', 404);
    if (driver && booking.driverId !== driver.id && booking.driverId !== userId) {
      throw AppException.forbidden();
    }

    if (!otp || typeof otp !== 'string' || !otp.trim()) {
      throw new AppException('BAD_REQUEST', 'Start trip OTP is required to start the delivery', 400);
    }

    // Verify OTP against Redis key
    let cachedOtp: string | null = null;
    try {
      cachedOtp = await this.redisService.client.get(`booking:${bookingId}:start_otp`);
    } catch (_) {
      // Redis fallback
    }

    if (!cachedOtp) {
      throw new AppException('BAD_REQUEST', 'Trip start OTP has expired or was not generated. Please request a new OTP.', 400);
    }

    if (otp.trim() !== cachedOtp.trim()) {
      throw new AppException('BAD_REQUEST', 'Invalid start trip OTP provided. Please verify with customer.', 400);
    }

    // Purge OTP from Redis immediately upon successful verification to prevent replay
    try {
      await this.redisService.client.del(`booking:${bookingId}:start_otp`);
    } catch (_) {}

    this.stateMachine.validateTransition(booking.status, 'TRIP_STARTED');

    const updated = await this.prisma.$transaction(async (tx) => {
      const result = await tx.booking.update({
        where: { id: bookingId },
        data: {
          status: 'TRIP_STARTED',
          tripStartedAt: new Date(),
        },
        include: {
          customer: { include: { user: true } },
          vehicleType: true,
        },
      });

      await tx.bookingStatusHistory.create({
        data: {
          bookingId,
          oldStatus: booking.status,
          newStatus: 'TRIP_STARTED',
          changedBy: userId,
        },
      });

      return result;
    });

    this.eventEmitter.emit('booking.trip_started', new BookingTripStartedEvent(bookingId));
    this.eventEmitter.emit('booking.status', {
      bookingId,
      status: 'TRIP_STARTED',
      booking: updated,
    });
    return updated;
  }

  async completeTrip(
    bookingId: string,
    userId: string,
    actualDistanceKm: number = 5.0,
    actualDurationMin: number = 15,
  ): Promise<unknown> {
    const driver = await this.prisma.driver.findUnique({ where: { userId } });
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const booking = (await this.findById(bookingId)) as any;
    if (!booking) throw new AppException('NOT_FOUND', 'Booking not found', 404);
    const resolvedDriverId = driver ? driver.id : booking.driverId;
    if (driver && booking.driverId !== driver.id && booking.driverId !== userId) {
      throw AppException.forbidden();
    }

    this.stateMachine.validateTransition(booking.status, 'TRIP_COMPLETED');

    const finalFare = booking.estimatedFare || (actualDistanceKm * 15 + actualDurationMin * 2);
    const resolvedPaymentStatus = booking.paymentStatus === 'SUCCESS' ? 'SUCCESS' : 'PENDING';

    const updated = await this.prisma.$transaction(async (tx) => {
      const result = await tx.booking.update({
        where: { id: bookingId },
        data: {
          status: 'TRIP_COMPLETED',
          tripCompletedAt: new Date(),
          actualDistanceKm,
          actualDurationMin,
          finalFare,
          paymentStatus: resolvedPaymentStatus,
        },
        include: {
          customer: { include: { user: true } },
          vehicleType: true,
        },
      });

      await tx.bookingStatusHistory.create({
        data: {
          bookingId,
          oldStatus: booking.status,
          newStatus: 'TRIP_COMPLETED',
          changedBy: userId,
        },
      });

      if (resolvedDriverId) {
        await tx.driver.update({
          where: { id: resolvedDriverId },
          data: {
            totalTrips: { increment: 1 },
            isAvailable: true,
          },
        });

        // Credit driver wallet with net earning after 15% platform commission
        const commissionPercent = 15;
        const driverEarning = Math.round(finalFare * (1 - commissionPercent / 100) * 100) / 100;

        let wallet = await tx.driverWallet.findUnique({ where: { driverId: resolvedDriverId } });
        if (!wallet) {
          wallet = await tx.driverWallet.create({
            data: { driverId: resolvedDriverId, balance: 0, totalEarned: 0, totalWithdrawn: 0 },
          });
        }

        const updatedWallet = await tx.driverWallet.update({
          where: { id: wallet.id },
          data: {
            balance: { increment: driverEarning },
            totalEarned: { increment: driverEarning },
          },
        });

        await tx.walletTransaction.create({
          data: {
            walletId: wallet.id,
            type: 'TRIP_EARNING',
            amount: driverEarning,
            balanceAfter: updatedWallet.balance,
            description: `Trip Earning (after ${commissionPercent}% platform commission) - #${booking.bookingNumber}`,
            referenceId: bookingId,
          },
        });
      }

      return result;
    });

    this.eventEmitter.emit(
      'booking.trip_completed',
      new BookingTripCompletedEvent(bookingId, finalFare),
    );
    this.eventEmitter.emit('booking.status', {
      bookingId,
      status: 'TRIP_COMPLETED',
      booking: updated,
    });
    return updated;
  }

  async simulateOrder(userId: string): Promise<unknown> {
    const driver = await this.prisma.driver.findUnique({
      where: { userId },
      include: { vehicle: { include: { vehicleType: true } } },
    });
    if (!driver || !driver.vehicle) {
      throw new AppException('BAD_REQUEST', 'Driver must have a registered vehicle to receive orders', 400);
    }

    let customer = await this.prisma.customer.findFirst({
      include: { user: true },
    });
    if (!customer) {
      let demoCustomerUser = await this.prisma.user.findFirst({
        where: { role: 'CUSTOMER' },
      });
      if (!demoCustomerUser) {
        demoCustomerUser = await this.prisma.user.create({
          data: {
            phone: '+919876500001',
            name: 'Priya Sharma',
            role: 'CUSTOMER',
            isVerified: true,
          },
        });
      }
      customer = await this.prisma.customer.create({
        data: {
          userId: demoCustomerUser.id,
          address: 'Connaught Place, New Delhi',
        },
        include: { user: true },
      });
    }

    const is2W = driver.vehicle.vehicleType?.name?.includes('2-Wheeler') ?? false;

    const bookingNumber = this.generateBookingNumber();
    const pickupLocations = [
      'Connaught Place, Inner Circle, New Delhi',
      'Karol Bagh Market, New Delhi',
      'Lajpat Nagar Central Market, New Delhi',
      'Chandni Chowk, Old Delhi',
    ];
    const dropLocations = [
      'Noida Sector 18, Commercial Belt',
      'Cyber City, DLF Phase 2, Gurugram',
      'Indirapuram, Ghaziabad',
      'Saket District Centre, South Delhi',
    ];

    const pickup = pickupLocations[Math.floor(Math.random() * pickupLocations.length)];
    const drop = dropLocations[Math.floor(Math.random() * dropLocations.length)];

    const booking = await this.prisma.booking.create({
      data: {
        bookingNumber,
        customerId: customer.id,
        vehicleTypeId: driver.vehicle.vehicleTypeId,
        pickupAddress: pickup,
        pickupLat: 28.6315,
        pickupLng: 77.2167,
        dropAddress: drop,
        dropLat: 28.5700,
        dropLng: 77.3200,
        packageType: is2W ? 'Parcel & Documents' : 'Commercial Cargo',
        packageDescription: is2W ? 'Electronic components & urgent documents' : 'Wholesale FMCG boxes (packed)',
        packageWeightKg: is2W ? 4.5 : 350.0,
        estimatedDistanceKm: 8.5,
        estimatedDurationMin: 25,
        estimatedFare: is2W ? 180.0 : 650.0,
        finalFare: is2W ? 180.0 : 650.0,
        status: 'REQUESTED',
        paymentMethod: 'CASH',
        paymentStatus: 'PENDING',
      },
      include: {
        customer: { include: { user: true } },
        vehicleType: true,
      },
    });

    const startOtp = Math.floor(1000 + Math.random() * 9000).toString();
    try {
      await this.redisService.client.set(
        `booking:${booking.id}:start_otp`,
        startOtp,
        'EX',
        86400,
      );
    } catch (_) {}

    this.eventEmitter.emit('booking.created', {
      ...booking,
      startOtp,
    });

    return {
      ...booking,
      startOtp,
    };
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
