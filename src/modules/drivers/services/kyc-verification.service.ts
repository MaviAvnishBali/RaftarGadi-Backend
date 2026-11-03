import { Injectable, Logger } from '@nestjs/common';
import { AppException } from '../../../common/exceptions/app.exception';
import { SubmitKycDto } from '../dto/submit-kyc.dto';

export interface VerificationResult {
  isValid: boolean;
  name?: string;
  issuedAt?: string;
  validUpto?: string;
  providerDetails?: any;
}

export interface AadhaarVerificationResult {
  isValid: boolean;
  maskedAadhaar: string;
  name?: string;
  dob?: string;
  gender?: string;
  providerDetails?: any;
}

@Injectable()
export class KycVerificationService {
  private readonly logger = new Logger(KycVerificationService.name);

  /**
   * Generates UIDAI-compliant masked Aadhaar (e.g. XXXXXXXX5678).
   */
  maskAadhaar(aadhaarNumber: string): string {
    const cleanNumber = aadhaarNumber.replace(/[\s-]/g, '');
    if (cleanNumber.length < 4) return cleanNumber;
    return 'X'.repeat(cleanNumber.length - 4) + cleanNumber.slice(-4);
  }

  /**
   * Prepares and validates KYC payload for current direct DB storage,
   * keeping the provider abstraction ready for 3rd-party integrations (Zoop/Setu).
   */
  async processKycSubmission(dto: SubmitKycDto) {
    this.logger.log(`Processing driver KYC submission for DL: ${dto.licenseNumber}`);

    const cleanAadhaar = dto.aadhaarNumber.replace(/[\s-]/g, '');
    const maskedAadhaar = this.maskAadhaar(cleanAadhaar);

    // In current simple mode: validate formats, generate masked values, and prepare record.
    // In future KYC live mode: this can call Zoop / Setu / Surepass APIs here.
    return {
      licenseNumber: dto.licenseNumber.toUpperCase().trim(),
      dob: new Date(dto.dob),
      licenseExpiry: dto.licenseExpiry ? new Date(dto.licenseExpiry) : undefined,
      aadhaarNumber: cleanAadhaar,
      maskedAadhaar,
      aadhaarName: dto.aadhaarName.trim(),
      kycSubmittedAt: new Date(),
      // Ready for future 3rd-party transaction ID
      kycProviderReference: `DEV_REF_${Date.now()}`,
    };
  }

  /**
   * Mocks a 3rd-party API call (e.g., Zoop, Setu) to verify a Driving License.
   */
  async verifyDrivingLicense(licenseNumber: string): Promise<VerificationResult> {
    this.logger.log(`Initiating 3rd-party DL verification for: ${licenseNumber}`);
    
    // Simulate network delay
    await new Promise((resolve) => setTimeout(resolve, 1000));

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
