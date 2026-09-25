export interface DashboardStats {
  totalCustomers: number;
  totalDrivers: number;
  activeDrivers: number;
  totalBookings: number;
  activeBookings: number;
  completedBookings: number;
  cancelledBookings: number;
  totalRevenue: number;
  pendingKyc: number;
  openTickets: number;
}

export interface RevenueReport {
  totalRevenue: number;
  totalTrips: number;
  averageFare: number;
  totalPlatformFees: number;
  revenueByVehicleType: Array<{ vehicleType: string; revenue: number; trips: number }>;
}

export interface DriverPerformanceReport {
  driverId: string;
  driverName: string;
  totalTrips: number;
  totalEarnings: number;
  averageRating: number;
  cancellationRate: number;
}

export interface BookingTrend {
  date: string;
  totalBookings: number;
  completedBookings: number;
  cancelledBookings: number;
  revenue: number;
}
