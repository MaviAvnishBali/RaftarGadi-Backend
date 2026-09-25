import { HttpException, HttpStatus } from '@nestjs/common';

export interface AppErrorResponse {
  code: string;
  message: string;
  details?: unknown[];
}

export class AppException extends HttpException {
  public readonly errorCode: string;

  constructor(
    errorCode: string,
    message: string,
    statusCode: HttpStatus = HttpStatus.BAD_REQUEST,
    details?: unknown[],
  ) {
    const response: AppErrorResponse = {
      code: errorCode,
      message,
      ...(details && { details }),
    };
    super(response, statusCode);
    this.errorCode = errorCode;
  }

  // ─── Auth Errors ──────────────────────────────────────
  static invalidOtp(): AppException {
    return new AppException('AUTH_INVALID_OTP', 'Invalid or expired OTP', HttpStatus.UNAUTHORIZED);
  }

  static otpMaxAttempts(): AppException {
    return new AppException(
      'AUTH_OTP_MAX_ATTEMPTS',
      'Maximum OTP attempts exceeded',
      HttpStatus.TOO_MANY_REQUESTS,
    );
  }

  static invalidToken(): AppException {
    return new AppException(
      'AUTH_INVALID_TOKEN',
      'Invalid or expired token',
      HttpStatus.UNAUTHORIZED,
    );
  }

  static refreshTokenRevoked(): AppException {
    return new AppException(
      'AUTH_TOKEN_REVOKED',
      'Refresh token has been revoked',
      HttpStatus.UNAUTHORIZED,
    );
  }

  static unauthorized(): AppException {
    return new AppException(
      'AUTH_UNAUTHORIZED',
      'Authentication required',
      HttpStatus.UNAUTHORIZED,
    );
  }

  static forbidden(): AppException {
    return new AppException('AUTHZ_FORBIDDEN', 'Insufficient permissions', HttpStatus.FORBIDDEN);
  }

  // ─── User Errors ──────────────────────────────────────
  static userNotFound(): AppException {
    return new AppException('USER_NOT_FOUND', 'User not found', HttpStatus.NOT_FOUND);
  }

  static userDeactivated(): AppException {
    return new AppException(
      'USER_DEACTIVATED',
      'User account is deactivated',
      HttpStatus.FORBIDDEN,
    );
  }

  // ─── Booking Errors ───────────────────────────────────
  static bookingNotFound(): AppException {
    return new AppException('BOOKING_NOT_FOUND', 'Booking not found', HttpStatus.NOT_FOUND);
  }

  static bookingInvalidState(current: string, target: string): AppException {
    return new AppException(
      'BOOKING_INVALID_STATE',
      `Cannot transition from ${current} to ${target}`,
      HttpStatus.CONFLICT,
    );
  }

  static bookingAlreadyExists(): AppException {
    return new AppException(
      'BOOKING_DUPLICATE',
      'A booking with this idempotency key already exists',
      HttpStatus.CONFLICT,
    );
  }

  // ─── Driver Errors ────────────────────────────────────
  static driverNotFound(): AppException {
    return new AppException('DRIVER_NOT_FOUND', 'Driver not found', HttpStatus.NOT_FOUND);
  }

  static driverNotAvailable(): AppException {
    return new AppException(
      'DRIVER_NOT_AVAILABLE',
      'No drivers available nearby',
      HttpStatus.NOT_FOUND,
    );
  }

  static driverNotApproved(): AppException {
    return new AppException(
      'DRIVER_NOT_APPROVED',
      'Driver KYC is not approved',
      HttpStatus.FORBIDDEN,
    );
  }

  static driverSuspended(): AppException {
    return new AppException(
      'DRIVER_SUSPENDED',
      'Driver account is suspended',
      HttpStatus.FORBIDDEN,
    );
  }

  // ─── Payment Errors ───────────────────────────────────
  static paymentNotFound(): AppException {
    return new AppException('PAYMENT_NOT_FOUND', 'Payment not found', HttpStatus.NOT_FOUND);
  }

  static paymentFailed(): AppException {
    return new AppException(
      'PAYMENT_FAILED',
      'Payment processing failed',
      HttpStatus.PAYMENT_REQUIRED,
    );
  }

  static paymentDuplicate(): AppException {
    return new AppException('PAYMENT_DUPLICATE', 'Duplicate payment request', HttpStatus.CONFLICT);
  }

  // ─── Wallet Errors ────────────────────────────────────
  static walletNotFound(): AppException {
    return new AppException('WALLET_NOT_FOUND', 'Wallet not found', HttpStatus.NOT_FOUND);
  }

  static insufficientBalance(): AppException {
    return new AppException(
      'WALLET_INSUFFICIENT_BALANCE',
      'Insufficient wallet balance',
      HttpStatus.BAD_REQUEST,
    );
  }

  // ─── Coupon Errors ────────────────────────────────────
  static couponNotFound(): AppException {
    return new AppException('COUPON_NOT_FOUND', 'Coupon not found', HttpStatus.NOT_FOUND);
  }

  static couponInvalid(): AppException {
    return new AppException(
      'COUPON_INVALID',
      'Coupon is invalid or expired',
      HttpStatus.BAD_REQUEST,
    );
  }

  static couponMaxUsesReached(): AppException {
    return new AppException(
      'COUPON_MAX_USES',
      'Coupon has reached maximum uses',
      HttpStatus.BAD_REQUEST,
    );
  }

  // ─── Vehicle Errors ───────────────────────────────────
  static vehicleTypeNotFound(): AppException {
    return new AppException(
      'VEHICLE_TYPE_NOT_FOUND',
      'Vehicle type not found',
      HttpStatus.NOT_FOUND,
    );
  }

  // ─── Pricing Errors ───────────────────────────────────
  static pricingRuleNotFound(): AppException {
    return new AppException(
      'PRICING_RULE_NOT_FOUND',
      'No pricing rule found for this vehicle type',
      HttpStatus.NOT_FOUND,
    );
  }

  // ─── Generic Errors ───────────────────────────────────
  static notFound(entity: string): AppException {
    return new AppException(
      `${entity.toUpperCase()}_NOT_FOUND`,
      `${entity} not found`,
      HttpStatus.NOT_FOUND,
    );
  }

  static conflict(message: string): AppException {
    return new AppException('CONFLICT', message, HttpStatus.CONFLICT);
  }

  static internal(message: string = 'Internal server error'): AppException {
    return new AppException('SYSTEM_INTERNAL_ERROR', message, HttpStatus.INTERNAL_SERVER_ERROR);
  }
}
