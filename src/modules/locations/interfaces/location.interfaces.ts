export interface LocationUpdatePayload {
  latitude: number;
  longitude: number;
  heading?: number;
  speed?: number;
  accuracyMeters?: number;
  bookingId?: string;
  timestamp?: number;
}

export interface NearbyDriver {
  driverId: string;
  distanceKm: number;
}
