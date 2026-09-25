import { Injectable } from '@nestjs/common';
import { ReportsRepository } from '../repositories/reports.repository';
import {
  DashboardStats,
  RevenueReport,
  DriverPerformanceReport,
  BookingTrend,
} from '../interfaces/report.interfaces';
import { ReportQueryDto } from '../dto/report-query.dto';

@Injectable()
export class ReportsService {
  constructor(private readonly reportsRepository: ReportsRepository) {}

  async getDashboardStats(): Promise<DashboardStats> {
    return this.reportsRepository.getDashboardStats();
  }

  async getRevenueReport(from: Date, to: Date): Promise<RevenueReport> {
    return this.reportsRepository.getRevenueReport(from, to);
  }

  async getDriverPerformanceReport(query: ReportQueryDto): Promise<DriverPerformanceReport[]> {
    return this.reportsRepository.getDriverPerformanceReport();
  }

  async getBookingTrends(
    from: Date,
    to: Date,
    interval: 'day' | 'week' | 'month',
  ): Promise<BookingTrend[]> {
    return this.reportsRepository.getBookingTrends(from, to, interval);
  }
}
