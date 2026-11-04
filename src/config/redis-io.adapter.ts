import { IoAdapter } from '@nestjs/platform-socket.io';
import { ServerOptions } from 'socket.io';
import { createAdapter } from '@socket.io/redis-adapter';
import Redis from 'ioredis';
import { Logger } from '@nestjs/common';

export class RedisIoAdapter extends IoAdapter {
  private readonly logger = new Logger(RedisIoAdapter.name);
  private adapterConstructor?: (nsp: any) => any;

  async connectToRedis(host: string, port: number, password?: string): Promise<void> {
    try {
      const pubClient = new Redis({
        host,
        port,
        password: password || undefined,
        maxRetriesPerRequest: 3,
        lazyConnect: false,
      });

      const subClient = pubClient.duplicate();

      this.adapterConstructor = createAdapter(pubClient, subClient);
      this.logger.log(`Clustered RedisIoAdapter connected to ${host}:${port}`);
    } catch (err: any) {
      this.logger.error(`Failed to initialize RedisIoAdapter: ${err?.message || err}`);
    }
  }

  createIOServer(port: number, options?: ServerOptions): any {
    const server = super.createIOServer(port, options);
    if (this.adapterConstructor) {
      server.adapter(this.adapterConstructor);
    }
    return server;
  }
}
