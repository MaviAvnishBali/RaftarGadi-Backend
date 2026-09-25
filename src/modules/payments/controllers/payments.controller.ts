import {
  Controller,
  Post,
  Get,
  Body,
  Param,
  Query,
  Headers,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation, ApiHeader } from '@nestjs/swagger';
import { PaymentsService } from '../services/payments.service';
import { InitiatePaymentDto } from '../dto/initiate-payment.dto';
import { WebhookPayloadDto } from '../dto/webhook-payload.dto';
import { PaymentQueryDto } from '../dto/payment-query.dto';
import { Public, Roles } from '../../../common/decorators';
import { Role } from '../../../common/enums';

@ApiTags('Payments')
@ApiBearerAuth('access-token')
@Controller({ path: 'payments', version: '1' })
export class PaymentsController {
  constructor(private readonly paymentsService: PaymentsService) {}

  @Roles(Role.CUSTOMER)
  @Post('initiate')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Initiate payment' })
  @ApiHeader({ name: 'idempotency-key', required: false })
  async initiatePayment(
    @Body() dto: InitiatePaymentDto,
    @Headers('idempotency-key') idempotencyKey?: string,
  ) {
    return this.paymentsService.initiatePayment(dto.bookingId, dto.method, idempotencyKey);
  }

  @Public()
  @Post('webhook')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Process payment webhook' })
  async processWebhook(@Body() payload: WebhookPayloadDto) {
    await this.paymentsService.processWebhook(payload);
    return { received: true };
  }

  @Get('booking/:bookingId')
  @ApiOperation({ summary: 'Get payments for a booking' })
  async getPaymentByBooking(@Param('bookingId') bookingId: string) {
    return this.paymentsService.getPaymentByBooking(bookingId);
  }

  @Roles(Role.ADMIN)
  @Get()
  @ApiOperation({ summary: 'List all payments' })
  async getAllPayments(@Query() query: PaymentQueryDto) {
    return this.paymentsService.getAllPayments(query);
  }

  @Roles(Role.ADMIN)
  @Post(':id/refund')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Refund a payment' })
  async refundPayment(@Param('id') id: string, @Body('reason') reason: string) {
    return this.paymentsService.refundPayment(id, reason || 'Requested by admin');
  }
}
