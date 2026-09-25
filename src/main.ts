import { NestFactory } from '@nestjs/core';
import { ValidationPipe, VersioningType } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { Logger } from 'nestjs-pino';
import helmet from 'helmet';
import compression from 'compression';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';

async function bootstrap(): Promise<void> {
  const app = await NestFactory.create(AppModule, {
    bufferLogs: true,
  });

  const configService = app.get(ConfigService);
  const logger = app.get(Logger);

  // Use Pino logger
  app.useLogger(logger);

  // Security
  app.use(helmet());
  app.use(compression());

  // CORS
  const corsOrigins = configService.get<string>('CORS_ORIGINS', 'http://localhost:3000');
  app.enableCors({
    origin: corsOrigins.split(','),
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'Idempotency-Key', 'X-Request-ID'],
    credentials: true,
  });

  // Global prefix and versioning
  app.setGlobalPrefix('api');
  app.enableVersioning({
    type: VersioningType.URI,
    defaultVersion: '1',
  });

  // Global validation pipe
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
      transformOptions: {
        enableImplicitConversion: true,
      },
    }),
  );

  // Swagger/OpenAPI documentation
  const swaggerConfig = new DocumentBuilder()
    .setTitle('RaftarGadi API')
    .setDescription('Production-grade logistics and on-demand goods transportation API')
    .setVersion('1.0')
    .addBearerAuth(
      {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
        name: 'Authorization',
        description: 'Enter JWT access token',
        in: 'header',
      },
      'access-token',
    )
    .addTag('Auth', 'Authentication & authorization')
    .addTag('Customers', 'Customer management')
    .addTag('Drivers', 'Driver management')
    .addTag('Vehicles', 'Vehicle management')
    .addTag('Bookings', 'Booking lifecycle')
    .addTag('Pricing', 'Pricing & fare calculation')
    .addTag('Payments', 'Payment processing')
    .addTag('Wallets', 'Driver wallet & transactions')
    .addTag('Locations', 'Real-time location tracking')
    .addTag('Ratings', 'Trip ratings')
    .addTag('Coupons', 'Coupon management')
    .addTag('Notifications', 'Push, SMS, Email notifications')
    .addTag('Support', 'Support tickets')
    .addTag('Admin', 'Admin dashboard & management')
    .addTag('Health', 'Health check endpoints')
    .build();

  const document = SwaggerModule.createDocument(app, swaggerConfig);
  SwaggerModule.setup('api/docs', app, document, {
    swaggerOptions: {
      persistAuthorization: true,
      tagsSorter: 'alpha',
      operationsSorter: 'alpha',
    },
  });

  // Request body size limit
  app.use(require('express').json({ limit: '10mb' }));

  const port = configService.get<number>('PORT', 3000);
  await app.listen(port);

  logger.log(`🚀 RaftarGadi API running on port ${port}`, 'Bootstrap');
  logger.log(`📖 Swagger docs at http://localhost:${port}/api/docs`, 'Bootstrap');
}

bootstrap();
