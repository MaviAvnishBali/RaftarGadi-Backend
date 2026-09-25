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
import { Logger } from '@nestjs/common';

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
  ) {}

  afterInit(server: Server) {
    this.logger.log('WebSocket Gateway Initialized');
  }

  async handleConnection(client: Socket) {
    try {
      const token =
        client.handshake.auth.token || client.handshake.headers['authorization']?.split(' ')[1];
      if (!token) {
        client.disconnect();
        return;
      }

      const payload = this.jwtService.verify(token);
      client.data.user = payload;

      const redisClient = this.redisService.client;
      await redisClient.set(`ws:client:${payload.sub}`, client.id);

      this.logger.log(`Client connected: ${client.id} (User: ${payload.sub})`);
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
        await this.locationsService.removeDriverLocation(userId);
      }

      this.logger.log(`Client disconnected: ${client.id} (User: ${userId})`);
    }
  }

  @SubscribeMessage('location:update')
  async handleLocationUpdate(client: Socket, payload: LocationUpdatePayload): Promise<void> {
    if (!client.data.user || client.data.user.role !== 'DRIVER') {
      return;
    }

    const driverId = client.data.user.sub;
    await this.locationsService.updateDriverLocation(driverId, payload.latitude, payload.longitude);

    if (payload.bookingId) {
      this.sendToBookingRoom(payload.bookingId, 'driver:location', {
        driverId,
        latitude: payload.latitude,
        longitude: payload.longitude,
        heading: payload.heading,
        speed: payload.speed,
      });
      // Optionally save to DB periodically
    }
  }

  @SubscribeMessage('driver:online')
  async handleDriverOnline(client: Socket): Promise<void> {
    if (client.data.user && client.data.user.role === 'DRIVER') {
      const driverId = client.data.user.sub;
      this.logger.log(`Driver online: ${driverId}`);
    }
  }

  @SubscribeMessage('driver:offline')
  async handleDriverOffline(client: Socket): Promise<void> {
    if (client.data.user && client.data.user.role === 'DRIVER') {
      const driverId = client.data.user.sub;
      await this.locationsService.removeDriverLocation(driverId);
      this.logger.log(`Driver offline: ${driverId}`);
    }
  }

  @SubscribeMessage('booking:join')
  async handleBookingJoin(client: Socket, payload: { bookingId: string }): Promise<void> {
    if (client.data.user) {
      client.join(`booking:${payload.bookingId}`);
      this.logger.log(`User ${client.data.user.sub} joined booking room ${payload.bookingId}`);
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
}
