import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  OnGatewayInit,
  OnGatewayConnection,
  OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { JwtService } from '@nestjs/jwt';
import { LocationsService } from '../services/locations.service';
import { LocationUpdatePayload } from '../interfaces/location.interfaces';
import { RedisService } from '../../../config/redis.service';
import { PrismaService } from '../../../database/prisma.service';
import { Logger } from '@nestjs/common';
import { OnEvent } from '@nestjs/event-emitter';

@WebSocketGateway({
  namespace: '/ws',
  cors: { origin: '*' },
})
export class LocationGateway implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer() server!: Server;
  private readonly logger = new Logger(LocationGateway.name);

  constructor(
    private readonly locationsService: LocationsService,
    private readonly jwtService: JwtService,
    private readonly redisService: RedisService,
    private readonly prisma: PrismaService,
  ) {}

  afterInit(server: Server) {
    this.logger.log('WebSocket Gateway Initialized');
  }

  async handleConnection(client: Socket) {
    try {
      const token =
        client.handshake.auth?.token ||
        client.handshake.headers['authorization']?.split(' ')[1] ||
        (client.handshake.query?.token as string);

      if (!token) {
        this.logger.warn(`Client ${client.id} rejected: No auth token provided`);
        client.disconnect();
        return;
      }

      let payload: any;
      try {
        payload = this.jwtService.verify(token);
      } catch (err) {
        this.logger.warn(`Client ${client.id} rejected: Invalid or unverified JWT token`);
        client.disconnect();
        return;
      }

      client.data.user = payload;

      const redisClient = this.redisService.client;
      await redisClient.set(`ws:client:${payload.sub}`, client.id);

      // Cache driver ID if user is DRIVER
      if (payload.role === 'DRIVER') {
        const driver = await this.prisma.driver.findUnique({
          where: { userId: payload.sub },
          select: { id: true },
        });
        if (driver) {
          client.data.driverId = driver.id;
        }
      }

      this.logger.log(`Client connected: ${client.id} (User: ${payload.sub}, Role: ${payload.role})`);
    } catch (error) {
      client.disconnect();
    }
  }

  async handleDisconnect(client: Socket) {
    if (client.data.user) {
      const userId = client.data.user.sub;
      const role = client.data.user.role;

      const redisClient = this.redisService.client;
      await redisClient.del(`ws:client:${userId}`);

      if (role === 'DRIVER') {
        const driverId = client.data.driverId || userId;
        await this.locationsService.removeDriverLocation(driverId);
        try {
          const activeBooking = await this.prisma.booking.findFirst({
            where: {
              driverId,
              status: { in: ['DRIVER_ASSIGNED', 'DRIVER_ARRIVING', 'DRIVER_ARRIVED', 'TRIP_STARTED'] },
            },
          });
          if (!activeBooking) {
            await this.prisma.driver.updateMany({
              where: { id: driverId },
              data: { status: 'OFFLINE', isAvailable: false },
            });
            this.logger.log(`Driver ${driverId} set to OFFLINE on WebSocket disconnect`);
          }
        } catch (dbErr) {
          this.logger.error(`Error updating driver status on disconnect: ${dbErr}`);
        }
      }

      this.logger.log(`Client disconnected: ${client.id} (User: ${userId})`);
    }
  }

  @SubscribeMessage('location:update')
  async handleLocationUpdate(client: Socket, payload: LocationUpdatePayload): Promise<void> {
    if (!client.data.user || client.data.user.role !== 'DRIVER') {
      return;
    }

    const userId = client.data.user.sub;
    const lat = Number(payload.latitude);
    const lng = Number(payload.longitude);

    // 1. Validate coordinate ranges
    if (isNaN(lat) || isNaN(lng) || lat < -90 || lat > 90 || lng < -180 || lng > 180) {
      this.logger.warn(`Driver ${userId} sent invalid coordinates: (${lat}, ${lng})`);
      return;
    }

    // 2. Resolve Driver profile
    let driverId = client.data.driverId;
    if (!driverId) {
      const driver = await this.prisma.driver.findUnique({
        where: { userId },
        select: { id: true },
      });
      if (driver) {
        driverId = driver.id;
        client.data.driverId = driver.id;
      }
    }

    if (!driverId) {
      return;
    }

    // 3. Update Redis online geospatial index
    await this.locationsService.updateDriverLocation(
      driverId,
      lat,
      lng,
      payload.heading,
      payload.speed,
    );

    // 4. If bookingId is provided, authorize and stream to customer room
    if (payload.bookingId) {
      const booking = await this.prisma.booking.findUnique({
        where: { id: payload.bookingId },
        select: {
          id: true,
          status: true,
          driverId: true,
        },
      });

      if (!booking || booking.driverId !== driverId) {
        this.logger.warn(`Driver ${driverId} not authorized for booking ${payload.bookingId}`);
        return;
      }

      // Only stream/persist if booking is active
      const activeStatuses = ['DRIVER_ASSIGNED', 'DRIVER_ARRIVING', 'DRIVER_ARRIVED', 'TRIP_STARTED'];
      if (!activeStatuses.includes(booking.status)) {
        return;
      }

      // Persist location to PostgreSQL booking_locations
      await this.locationsService.saveBookingLocation(
        payload.bookingId,
        lat,
        lng,
        payload.heading,
        payload.speed,
      );

      // Broadcast real-time driver:location to the customer's room
      this.sendToBookingRoom(payload.bookingId, 'driver:location', {
        bookingId: payload.bookingId,
        driverId,
        latitude: lat,
        longitude: lng,
        heading: payload.heading ?? 0,
        speed: payload.speed ?? 0,
        accuracyMeters: payload.accuracyMeters ?? 5,
        recordedAt: new Date().toISOString(),
      });
    }
  }

  @SubscribeMessage('driver:online')
  async handleDriverOnline(client: Socket): Promise<void> {
    if (client.data.user && client.data.user.role === 'DRIVER') {
      const driverId = client.data.driverId || client.data.user.sub;
      this.logger.log(`Driver online: ${driverId}`);
    }
  }

  @SubscribeMessage('driver:offline')
  async handleDriverOffline(client: Socket): Promise<void> {
    if (client.data.user && client.data.user.role === 'DRIVER') {
      const driverId = client.data.driverId || client.data.user.sub;
      await this.locationsService.removeDriverLocation(driverId);
      this.logger.log(`Driver offline: ${driverId}`);
    }
  }

  @SubscribeMessage('booking:join')
  async handleBookingJoin(client: Socket, payload: { bookingId: string }): Promise<void> {
    if (!client.data.user || !payload?.bookingId) {
      return;
    }

    const userId = client.data.user.sub;
    const role = client.data.user.role;

    // Admins can monitor any room
    if (role === 'ADMIN') {
      client.join(`booking:${payload.bookingId}`);
      this.logger.log(`Admin ${userId} joined booking room ${payload.bookingId}`);
      return;
    }

    // Verify booking authorization
    const booking = await this.prisma.booking.findUnique({
      where: { id: payload.bookingId },
      select: {
        id: true,
        customer: { select: { userId: true } },
        driver: { select: { userId: true } },
      },
    });

    if (!booking) {
      client.emit('error', { message: 'Booking not found' });
      return;
    }

    const isCustomer = booking.customer?.userId === userId;
    const isDriver = booking.driver?.userId === userId;

    if (isCustomer || isDriver) {
      client.join(`booking:${payload.bookingId}`);
      this.logger.log(`Authorized user ${userId} (${role}) joined booking room ${payload.bookingId}`);
    } else {
      this.logger.warn(`Unauthorized join attempt to booking ${payload.bookingId} by user ${userId}`);
      client.emit('error', { message: 'Unauthorized for this booking room' });
    }
  }

  async sendToUser(userId: string, event: string, data: unknown): Promise<void> {
    const redisClient = this.redisService.client;
    const socketId = await redisClient.get(`ws:client:${userId}`);
    if (socketId) {
      this.server.to(socketId).emit(event, data);
    }
  }

  sendToBookingRoom(bookingId: string, event: string, data: unknown): void {
    this.server.to(`booking:${bookingId}`).emit(event, data);
  }

  sendBookingRequest(driverId: string, bookingData: unknown): void {
    this.sendToUser(driverId, 'booking:request', bookingData);
  }

  @OnEvent('booking.created')
  async handleBookingCreated(payload: any): Promise<void> {
    const bookingId = payload.id;
    const pickupLat = Number(payload.pickupLat);
    const pickupLng = Number(payload.pickupLng);
    const vehicleTypeId = payload.vehicleTypeId;

    this.logger.log(`Dispatching geofenced booking request for ${bookingId} near (${pickupLat}, ${pickupLng})`);

    const requestPayload = {
      bookingId,
      bookingNumber: payload.bookingNumber,
      pickup: {
        latitude: pickupLat,
        longitude: pickupLng,
        address: payload.pickupAddress || 'Pickup Location',
      },
      drop: {
        latitude: Number(payload.dropLat),
        longitude: Number(payload.dropLng),
        address: payload.dropAddress || 'Drop Location',
      },
      vehicleType: payload.vehicleType?.name || payload.vehicleType || 'Cargo',
      vehicleTypeId,
      packageType: payload.packageType || 'Commercial Goods',
      packageWeightKg: payload.packageWeightKg,
      estimatedFare: payload.estimatedFare || payload.finalFare || 0,
      estimatedDistanceKm: payload.estimatedDistanceKm || 0,
      estimatedDurationMin: payload.estimatedDurationMin || 0,
      expiresAt: new Date(Date.now() + 45 * 1000).toISOString(),
    };

    if (isNaN(pickupLat) || isNaN(pickupLng)) {
      this.logger.warn(`Invalid pickup coordinates for booking ${bookingId}; skipping dispatch`);
      return;
    }

    // Configurable progressive search radii: 10km -> 15km -> 25km
    const searchRadii = [10, 15, 25];
    const eligibleDrivers: { driverId: string; userId: string; distanceKm: number }[] = [];
    const notifiedDriverUserIds = new Set<string>();

    for (const radiusKm of searchRadii) {
      const candidates = await this.locationsService.findNearbyDrivers(pickupLat, pickupLng, radiusKm, 50);
      if (candidates.length === 0) continue;

      const candidateDriverIds = candidates.map((c) => c.driverId);

      // Reconcile against authoritative PostgreSQL driver state
      const availableDrivers = await this.prisma.driver.findMany({
        where: {
          id: { in: candidateDriverIds },
          status: 'ONLINE',
          isAvailable: true,
          bookings: {
            none: {
              status: { in: ['DRIVER_ASSIGNED', 'DRIVER_ARRIVING', 'DRIVER_ARRIVED', 'TRIP_STARTED'] },
            },
          },
          ...(vehicleTypeId
            ? {
                vehicle: {
                  vehicleTypeId,
                },
              }
            : {}),
        },
        select: {
          id: true,
          userId: true,
        },
      });

      const candidateMap = new Map(candidates.map((c) => [c.driverId, c.distanceKm]));

      for (const d of availableDrivers) {
        if (!notifiedDriverUserIds.has(d.userId)) {
          eligibleDrivers.push({
            driverId: d.id,
            userId: d.userId,
            distanceKm: candidateMap.get(d.id) ?? radiusKm,
          });
          notifiedDriverUserIds.add(d.userId);
        }
      }

      if (eligibleDrivers.length > 0) {
        this.logger.log(`Discovered ${eligibleDrivers.length} eligible drivers in ${radiusKm}km radius for booking ${bookingId}`);
        break;
      }
    }

    if (eligibleDrivers.length > 0) {
      const redisClient = this.redisService.client;
      for (const driver of eligibleDrivers) {
        const socketId = await redisClient.get(`ws:client:${driver.userId}`);
        if (socketId) {
          this.server.to(socketId).emit('booking:request', {
            ...requestPayload,
            distanceToPickupKm: Number(driver.distanceKm.toFixed(1)),
          });
        }
      }
    } else {
      // Fallback: If no drivers in 25km radius, check if any online available drivers exist
      this.logger.warn(`No nearby drivers within 25km for booking ${bookingId}. Fallback to online drivers.`);
      const fallbackDrivers = await this.prisma.driver.findMany({
        where: {
          status: 'ONLINE',
          isAvailable: true,
          bookings: {
            none: {
              status: { in: ['DRIVER_ASSIGNED', 'DRIVER_ARRIVING', 'DRIVER_ARRIVED', 'TRIP_STARTED'] },
            },
          },
        },
        select: { id: true, userId: true },
        take: 20,
      });

      const redisClient = this.redisService.client;
      for (const fd of fallbackDrivers) {
        const socketId = await redisClient.get(`ws:client:${fd.userId}`);
        if (socketId) {
          this.server.to(socketId).emit('booking:request', {
            ...requestPayload,
            isExpandedArea: true,
          });
        }
      }
    }
  }

  @OnEvent('booking.assigned')
  handleBookingAssigned(payload: { bookingId: string; assignedDriverId: string; status: string }): void {
    this.logger.log(`Broadcasting booking:taken for booking ${payload.bookingId}`);
    this.server.emit('booking:taken', {
      bookingId: payload.bookingId,
      assignedDriverId: payload.assignedDriverId,
      status: payload.status,
    });
  }

  @OnEvent('booking.status')
  handleBookingStatus(payload: { bookingId: string; status: string; booking: any }): void {
    this.logger.log(`Broadcasting booking:status for booking ${payload?.bookingId}: ${payload?.status}`);
    this.sendToBookingRoom(payload.bookingId, 'booking:status', payload);
  }

  @OnEvent('booking.cancelled')
  handleBookingCancelled(payload: { bookingId: string; cancelledBy: string; reason?: string }): void {
    this.logger.log(`Broadcasting booking:cancelled for booking ${payload?.bookingId}: ${payload?.reason}`);
    this.sendToBookingRoom(payload.bookingId, 'booking:status', {
      bookingId: payload.bookingId,
      status: 'CANCELLED',
      reason: payload.reason,
    });
  }

  @SubscribeMessage('support:join')
  async handleSupportJoin(client: Socket, data: { ticketId: string }) {
    if (!data?.ticketId || !client.data.user) {
      return { success: false, error: 'Unauthorized' };
    }

    const user = client.data.user;
    const isStaff = user.role === 'ADMIN' || user.role === 'SUPER_ADMIN';

    if (!isStaff) {
      const ticket = await this.prisma.supportTicket.findUnique({
        where: { id: data.ticketId },
        select: { userId: true },
      });
      if (!ticket || ticket.userId !== user.sub) {
        this.logger.warn(`User ${user.sub} unauthorized for support ticket ${data.ticketId}`);
        return { success: false, error: 'Unauthorized to join ticket room' };
      }
    }

    client.join(`support:ticket:${data.ticketId}`);
    this.logger.log(`Socket ${client.id} joined support room support:ticket:${data.ticketId}`);
    return { success: true, room: `support:ticket:${data.ticketId}` };
  }

  @SubscribeMessage('support:leave')
  handleSupportLeave(client: Socket, data: { ticketId: string }) {
    if (data?.ticketId) {
      client.leave(`support:ticket:${data.ticketId}`);
      return { success: true };
    }
  }

  @OnEvent('support.message')
  handleSupportMessage(payload: { ticketId: string; message: any }): void {
    this.logger.log(`Broadcasting support:message to room support:ticket:${payload.ticketId}`);
    this.server.to(`support:ticket:${payload.ticketId}`).emit('support:message', payload.message);
  }
}
