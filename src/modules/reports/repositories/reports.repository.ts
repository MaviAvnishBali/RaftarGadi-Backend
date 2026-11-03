import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../database/prisma.service';
import {
  DashboardStats,
  RevenueReport,
  DriverPerformanceReport,
  BookingTrend,
} from '../interfaces/report.interfaces';

@Injectable()
export class ReportsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async getDashboardStats(): Promise<DashboardStats> {
    try {
      const todayStart = new Date();
      todayStart.setHours(0, 0, 0, 0);

      const [
        totalCustomers,
        totalDrivers,
        activeDrivers,
        totalBookings,
        activeBookings,
        completedBookings,
        cancelledBookings,
        pendingKyc,
        openTickets,
        totalRevenueAgg,
        todayRevenueAgg,
        ratingAgg,
      ] = await Promise.all([
        this.prisma.customer.count(),
        this.prisma.driver.count(),
        this.prisma.driver.count({ where: { status: { in: ['ONLINE', 'BUSY'] } } }),
        this.prisma.booking.count(),
        this.prisma.booking.count({
          where: {
            status: { in: ['SEARCHING_DRIVER', 'DRIVER_ASSIGNED', 'DRIVER_ARRIVING', 'DRIVER_ARRIVED', 'TRIP_STARTED'] },
          },
        }),
        this.prisma.booking.count({ where: { status: { in: ['COMPLETED', 'TRIP_COMPLETED'] } } }),
        this.prisma.booking.count({ where: { status: 'CANCELLED' } }),
        this.prisma.driver.count({ where: { kycStatus: { in: ['PENDING', 'SUBMITTED'] } } }),
        this.prisma.supportTicket.count({ where: { status: { in: ['OPEN', 'IN_PROGRESS'] } } }),
        this.prisma.booking.aggregate({
          where: { status: { in: ['COMPLETED', 'TRIP_COMPLETED'] } },
          _sum: { finalFare: true },
        }),
        this.prisma.booking.aggregate({
          where: { status: { in: ['COMPLETED', 'TRIP_COMPLETED'] }, createdAt: { gte: todayStart } },
          _sum: { finalFare: true },
        }),
        this.prisma.rating.aggregate({
          _avg: { rating: true },
        }),
      ]);

      const totalRevenue = totalRevenueAgg._sum?.finalFare || 0;
      const todayRevenue = todayRevenueAgg._sum?.finalFare || 0;
      const avgRating = ratingAgg._avg?.rating ? Number(ratingAgg._avg.rating.toFixed(2)) : 0.0;
      const totalDecided = completedBookings + cancelledBookings;
      const completionRate = totalDecided > 0 ? Number(((completedBookings / totalDecided) * 100).toFixed(1)) : 100.0;

      return {
        totalCustomers: totalCustomers || 0,
        totalDrivers: totalDrivers || 0,
        activeDrivers: activeDrivers || 0,
        totalBookings: totalBookings || 0,
        activeBookings: activeBookings || 0,
        completedBookings: completedBookings || 0,
        cancelledBookings: cancelledBookings || 0,
        totalRevenue,
        todayRevenue,
        pendingKyc: pendingKyc || 0,
        pendingVerifications: pendingKyc || 0,
        completionRate,
        averageRating: avgRating,
        openTickets: openTickets || 0,
      };
    } catch (_) {
      return {
        totalCustomers: 0,
        totalDrivers: 0,
        activeDrivers: 0,
        totalBookings: 0,
        activeBookings: 0,
        completedBookings: 0,
        cancelledBookings: 0,
        totalRevenue: 0,
        todayRevenue: 0,
        pendingKyc: 0,
        pendingVerifications: 0,
        completionRate: 0,
        averageRating: 0,
        openTickets: 0,
      };
    }
  }

  async getRevenueReport(from: Date, to: Date): Promise<RevenueReport> {
    try {
      const [completedBookings, agg, trips] = await Promise.all([
        this.prisma.booking.count({
          where: { status: { in: ['COMPLETED', 'TRIP_COMPLETED'] }, createdAt: { gte: from, lte: to } },
        }),
        this.prisma.booking.aggregate({
          where: { status: { in: ['COMPLETED', 'TRIP_COMPLETED'] }, createdAt: { gte: from, lte: to } },
          _sum: { finalFare: true, platformFee: true },
          _avg: { finalFare: true },
        }),
        this.prisma.booking.findMany({
          where: { status: { in: ['COMPLETED', 'TRIP_COMPLETED'] }, createdAt: { gte: from, lte: to } },
          include: { vehicleType: true },
        }),
      ]);

      const totalRevenue = agg._sum?.finalFare || 0;
      const totalPlatformFees = agg._sum?.platformFee || Math.round(totalRevenue * 0.15);
      const driverPayouts = Math.round(totalRevenue - totalPlatformFees);
      const averageFare = agg._avg?.finalFare ? Math.round(agg._avg.finalFare) : 0;

      // Group by weekday
      const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
      const dailyMap: Record<string, number> = {};
      for (const d of ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']) {
        dailyMap[d] = 0;
      }
      for (const t of trips) {
        const dayName = days[new Date(t.createdAt).getDay()];
        dailyMap[dayName] = (dailyMap[dayName] || 0) + (t.finalFare || 0);
      }
      const dailyStats = Object.entries(dailyMap).map(([date, amount]) => ({ date, amount }));

      // Group by vehicle type
      const vMap: Record<string, { revenue: number; trips: number }> = {};
      for (const t of trips) {
        const vName = t.vehicleType?.name || 'Standard';
        if (!vMap[vName]) vMap[vName] = { revenue: 0, trips: 0 };
        vMap[vName].revenue += t.finalFare || 0;
        vMap[vName].trips += 1;
      }
      const revenueByVehicleType = Object.entries(vMap).map(([vehicleType, val]) => ({
        vehicleType,
        revenue: Math.round(val.revenue),
        trips: val.trips,
      }));

      return {
        totalRevenue,
        totalTrips: completedBookings,
        averageFare,
        totalPlatformFees,
        platformCommission: totalPlatformFees,
        driverPayouts,
        dailyStats,
        revenueByVehicleType,
      };
    } catch (_) {
      return {
        totalRevenue: 0,
        totalTrips: 0,
        averageFare: 0,
        totalPlatformFees: 0,
        platformCommission: 0,
        driverPayouts: 0,
        dailyStats: [],
        revenueByVehicleType: [],
      };
    }
  }

  async getDriverPerformanceReport(): Promise<DriverPerformanceReport[]> {
    try {
      const drivers = await this.prisma.driver.findMany({
        include: {
          user: true,
          bookings: {
            where: { status: { in: ['COMPLETED', 'TRIP_COMPLETED'] } },
          },
        },
      });

      return drivers.map((d) => {
        const trips = d.bookings.length;
        const earnings = d.bookings.reduce((sum, b) => sum + (b.finalFare || 0), 0);
        return {
          driverId: d.id,
          driverName: d.user?.name || 'Driver',
          totalTrips: trips,
          totalEarnings: earnings,
          averageRating: d.avgRating || 5.0,
          cancellationRate: 0,
        };
      });
    } catch (_) {
      return [];
    }
  }

  async getBookingTrends(
    from: Date,
    to: Date,
    interval: 'day' | 'week' | 'month',
  ): Promise<BookingTrend[]> {
    try {
      const bookings = await this.prisma.booking.findMany({
        where: { createdAt: { gte: from, lte: to } },
      });
      const completed = bookings.filter((b) => b.status === 'COMPLETED' || b.status === 'TRIP_COMPLETED');
      const cancelled = bookings.filter((b) => b.status === 'CANCELLED');
      const revenue = completed.reduce((sum, b) => sum + (b.finalFare || 0), 0);

      return [
        {
          date: new Date().toISOString(),
          totalBookings: bookings.length,
          completedBookings: completed.length,
          cancelledBookings: cancelled.length,
          revenue,
        },
      ];
    } catch (_) {
      return [];
    }
  }
}
