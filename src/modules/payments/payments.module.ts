import { Module } from '@nestjs/common';
import { PaymentsService } from './services/payments.service';
import { MockPaymentGateway } from './services/payment-gateway.service';
import { PaymentsController } from './controllers/payments.controller';
import { PaymentsRepository } from './repositories/payments.repository';
import { PrismaService } from '../../database/prisma.service';

@Module({
  controllers: [PaymentsController],
  providers: [PaymentsService, MockPaymentGateway, PaymentsRepository, PrismaService],
  exports: [PaymentsService],
})
export class PaymentsModule {}
