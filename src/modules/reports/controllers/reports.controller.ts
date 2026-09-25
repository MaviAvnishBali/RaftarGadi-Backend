import { Controller, Get, Query, Version } from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { Roles } from '../../../common/decorators';
import { Role } from '../../../common/enums';
import { ReportsService } from '../services/reports.service';
import { ReportQueryDto } from '../dto/report-query.dto';

@ApiTags('Admin')
@ApiBearerAuth('access-token')
@Controller('reports')
export class ReportsController {
  constructor(private readonly reportsService: ReportsService) {}

  @Version('1')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Get('dashboard')
  async getDashboardStats() {
    return this.reportsService.getDashboardStats();
  }

  @Version('1')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Get('revenue')
  async getRevenueReport(@Query() query: ReportQueryDto) {
    const from = query.from
      ? new Date(query.from)
      : new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);
    const to = query.to ? new Date(query.to) : new Date();
    return this.reportsService.getRevenueReport(from, to);
  }

  @Version('1')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Get('driver-performance')
  async getDriverPerformanceReport(@Query() query: ReportQueryDto) {
    return this.reportsService.getDriverPerformanceReport(query);
  }

  @Version('1')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Get('booking-trends')
  async getBookingTrends(@Query() query: ReportQueryDto) {
    const from = query.from
      ? new Date(query.from)
      : new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);
    const to = query.to ? new Date(query.to) : new Date();
    const interval = query.interval || 'day';
    return this.reportsService.getBookingTrends(from, to, interval);
  }
}
