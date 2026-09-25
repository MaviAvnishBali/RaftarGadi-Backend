import { Injectable, Logger } from '@nestjs/common';
import { AppException } from '../../../common/exceptions/app.exception';

export interface VerificationResult {
  isValid: boolean;
  name?: string;
  issuedAt?: string;
  validUpto?: string;
  providerDetails?: any;
}

@Injectable()
export class KycVerificationService {
  private readonly logger = new Logger(KycVerificationService.name);

  /**
   * Mocks a 3rd-party API call (e.g., Zoop, Setu) to verify a Driving License.
   */
  async verifyDrivingLicense(licenseNumber: string): Promise<VerificationResult> {
    this.logger.log(`Initiating 3rd-party DL verification for: ${licenseNumber}`);
    
    // Simulate network delay
    await new Promise((resolve) => setTimeout(resolve, 1500));

    // Mock validation logic:
    // Let's assume licenses ending with '0000' simulate a failure.
    if (licenseNumber.endsWith('0000')) {
      this.logger.warn(`DL verification failed for: ${licenseNumber}`);
      throw new AppException('KYC_ERROR', 'The provided Driving License could not be verified by the authorities.', 400);
    }

    this.logger.log(`DL verification successful for: ${licenseNumber}`);
    
    // Return mock success payload
    return {
      isValid: true,
      name: 'John Doe',
      issuedAt: '2015-05-20',
      validUpto: '2035-05-19',
      providerDetails: {
        status: 'ACTIVE',
        rto: 'Mock RTO',
      },
    };
  }
}
