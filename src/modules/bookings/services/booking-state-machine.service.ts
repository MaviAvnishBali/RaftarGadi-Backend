import { Injectable } from '@nestjs/common';
import { ALLOWED_TRANSITIONS, CANCELLABLE_STATUSES } from '../enums/booking-status.enum';
import { AppException } from '../../../common/exceptions/app.exception';

@Injectable()
export class BookingStateMachineService {
  canTransition(currentStatus: string, targetStatus: string): boolean {
    const allowed = ALLOWED_TRANSITIONS[currentStatus];
    return allowed ? allowed.includes(targetStatus) : false;
  }

  validateTransition(currentStatus: string, targetStatus: string): void {
    if (!this.canTransition(currentStatus, targetStatus)) {
      if ((AppException as any).bookingInvalidState) {
        throw (AppException as any).bookingInvalidState(currentStatus, targetStatus);
      } else {
        throw new AppException(
          'BAD_REQUEST',
          `Invalid booking state transition from ${currentStatus} to ${targetStatus}`,
          400,
        );
      }
    }
  }

  isCancellable(status: string): boolean {
    return CANCELLABLE_STATUSES.includes(status);
  }
}
