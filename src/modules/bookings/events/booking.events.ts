export class BookingCreatedEvent {
  constructor(
    public readonly bookingId: string,
    public readonly customerId: string,
    public readonly vehicleTypeId: string,
  ) {}
}

export class BookingDriverAssignedEvent {
  constructor(
    public readonly bookingId: string,
    public readonly driverId: string,
  ) {}
}

export class BookingTripStartedEvent {
  constructor(public readonly bookingId: string) {}
}

export class BookingTripCompletedEvent {
  constructor(
    public readonly bookingId: string,
    public readonly finalFare: number,
  ) {}
}

export class BookingCancelledEvent {
  constructor(
    public readonly bookingId: string,
    public readonly cancelledBy: string,
    public readonly reason?: string,
  ) {}
}

export class BookingPaymentCompletedEvent {
  constructor(public readonly bookingId: string) {}
}
