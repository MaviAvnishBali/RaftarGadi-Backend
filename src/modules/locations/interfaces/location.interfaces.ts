export interface LocationUpdatePayload {
  latitude: number;
  longitude: number;
  heading?: number;
  speed?: number;
  bookingId?: string;
}

export interface NearbyDriver {
  driverId: string;
  distanceKm: number;
}
