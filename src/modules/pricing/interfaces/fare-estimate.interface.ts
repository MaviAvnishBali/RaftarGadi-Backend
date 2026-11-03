export interface FareEstimate {
  baseFare: number;
  distanceCharge: number;
  timeCharge: number;
  subtotal: number;
  surgeMultiplier: number;
  surgeAmount: number;
  platformFee: number;
  taxAmount: number;
  discountAmount: number;
  totalFare: number;
  minimumFareApplied: boolean;
  currency: string;
  distanceFare?: number;
  timeFare?: number;
  distanceKm?: number;
  durationMinutes?: number;
  discount?: number;
}
