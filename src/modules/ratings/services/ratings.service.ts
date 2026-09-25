import { Injectable, HttpStatus } from '@nestjs/common';
import { RatingsRepository } from '../repositories/ratings.repository';
import { CreateRatingDto } from '../dto/create-rating.dto';
import { PrismaService } from '../../../database/prisma.service';
import { AppException } from '../../../common/exceptions/app.exception';
import { PaginationDto, PaginatedResponse } from '../../../common/dto/pagination.dto';

@Injectable()
export class RatingsService {
  constructor(
    private readonly ratingsRepo: RatingsRepository,
    private readonly prisma: PrismaService,
  ) {}

  async createRating(customerId: string, dto: CreateRatingDto) {
    return this.prisma.$transaction(async (tx) => {
      const booking = await tx.booking.findUnique({
        where: { id: dto.bookingId },
      });

      if (!booking) {
        throw new AppException('ERROR', 'Booking not found', HttpStatus.NOT_FOUND);
      }

      if (booking.customerId !== customerId) {
        throw new AppException('ERROR', 'Unauthorized to rate this booking', HttpStatus.FORBIDDEN);
      }

      if (booking.status !== 'COMPLETED') {
        throw new AppException('ERROR', 'Can only rate completed bookings', HttpStatus.BAD_REQUEST);
      }

      const existingRating = await tx.rating.findUnique({
        where: { bookingId: dto.bookingId },
      });

      if (existingRating) {
        throw new AppException('ERROR', 'Booking is already rated', HttpStatus.BAD_REQUEST);
      }

      const rating = await tx.rating.create({
        data: {
          bookingId: dto.bookingId,
          customerId,
          driverId: booking.driverId!,
          rating: dto.rating,
          review: dto.review,
        },
      });

      const driverRatings = await tx.rating.aggregate({
        where: { driverId: booking.driverId! },
        _avg: { rating: true },
      });

      await tx.driver.update({
        where: { id: booking.driverId! },
        data: { avgRating: driverRatings._avg.rating || 0 },
      });

      return rating;
    });
  }

  async getBookingRating(bookingId: string) {
    return this.ratingsRepo.findByBookingId(bookingId);
  }

  async getDriverRatings(driverId: string, query: PaginationDto) {
    const skip = (query.page - 1) * query.limit;
    const [items, total] = await Promise.all([
      this.ratingsRepo.findDriverRatings(driverId, skip, query.limit),
      this.ratingsRepo.countDriverRatings(driverId),
    ]);

    return {
      items,
      meta: {
        total,
        page: query.page,
        limit: query.limit,
        totalPages: Math.ceil(total / query.limit),
      },
    };
  }

  async getAverageRating(driverId: string): Promise<number> {
    const agg = await this.prisma.rating.aggregate({
      where: { driverId },
      _avg: { rating: true },
    });
    return agg._avg.rating || 0;
  }
}
