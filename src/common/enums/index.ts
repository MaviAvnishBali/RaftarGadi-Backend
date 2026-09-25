// ─────────────────────────────────────────────────────────────
// Common Enums — Central definitions for roles and permissions
// ─────────────────────────────────────────────────────────────

export enum Role {
  CUSTOMER = 'CUSTOMER',
  DRIVER = 'DRIVER',
  ADMIN = 'ADMIN',
  SUPER_ADMIN = 'SUPER_ADMIN',
}

export enum Permission {
  // Booking
  BOOKING_CREATE = 'BOOKING_CREATE',
  BOOKING_VIEW_OWN = 'BOOKING_VIEW_OWN',
  BOOKING_VIEW_ALL = 'BOOKING_VIEW_ALL',
  BOOKING_CANCEL_OWN = 'BOOKING_CANCEL_OWN',
  BOOKING_CANCEL_ALL = 'BOOKING_CANCEL_ALL',
  BOOKING_ACCEPT = 'BOOKING_ACCEPT',
  BOOKING_START = 'BOOKING_START',
  BOOKING_COMPLETE = 'BOOKING_COMPLETE',

  // Driver
  DRIVER_VIEW_OWN = 'DRIVER_VIEW_OWN',
  DRIVER_VIEW_ALL = 'DRIVER_VIEW_ALL',
  DRIVER_APPROVE = 'DRIVER_APPROVE',
  DRIVER_SUSPEND = 'DRIVER_SUSPEND',

  // Customer
  CUSTOMER_VIEW_OWN = 'CUSTOMER_VIEW_OWN',
  CUSTOMER_VIEW_ALL = 'CUSTOMER_VIEW_ALL',

  // Pricing
  PRICING_VIEW = 'PRICING_VIEW',
  PRICING_MANAGE = 'PRICING_MANAGE',

  // Payment
  PAYMENT_VIEW_OWN = 'PAYMENT_VIEW_OWN',
  PAYMENT_VIEW_ALL = 'PAYMENT_VIEW_ALL',
  PAYMENT_MANAGE = 'PAYMENT_MANAGE',

  // Wallet
  WALLET_VIEW_OWN = 'WALLET_VIEW_OWN',
  WALLET_VIEW_ALL = 'WALLET_VIEW_ALL',
  WALLET_MANAGE = 'WALLET_MANAGE',

  // Rating
  RATING_CREATE = 'RATING_CREATE',
  RATING_VIEW_ALL = 'RATING_VIEW_ALL',

  // Coupon
  COUPON_VIEW = 'COUPON_VIEW',
  COUPON_MANAGE = 'COUPON_MANAGE',

  // Support
  SUPPORT_CREATE = 'SUPPORT_CREATE',
  SUPPORT_VIEW_OWN = 'SUPPORT_VIEW_OWN',
  SUPPORT_MANAGE = 'SUPPORT_MANAGE',

  // Notification
  NOTIFICATION_SEND = 'NOTIFICATION_SEND',

  // Report
  REPORT_VIEW = 'REPORT_VIEW',

  // Admin
  ADMIN_MANAGE = 'ADMIN_MANAGE',
  SYSTEM_CONFIG = 'SYSTEM_CONFIG',
}

// ─── Role-Permission Mapping ──────────────────────────────

export const ROLE_PERMISSIONS: Record<Role, Permission[]> = {
  [Role.CUSTOMER]: [
    Permission.BOOKING_CREATE,
    Permission.BOOKING_VIEW_OWN,
    Permission.BOOKING_CANCEL_OWN,
    Permission.CUSTOMER_VIEW_OWN,
    Permission.PAYMENT_VIEW_OWN,
    Permission.RATING_CREATE,
    Permission.COUPON_VIEW,
    Permission.SUPPORT_CREATE,
    Permission.SUPPORT_VIEW_OWN,
  ],
  [Role.DRIVER]: [
    Permission.BOOKING_VIEW_OWN,
    Permission.BOOKING_ACCEPT,
    Permission.BOOKING_START,
    Permission.BOOKING_COMPLETE,
    Permission.DRIVER_VIEW_OWN,
    Permission.WALLET_VIEW_OWN,
    Permission.PAYMENT_VIEW_OWN,
    Permission.SUPPORT_CREATE,
    Permission.SUPPORT_VIEW_OWN,
  ],
  [Role.ADMIN]: [
    Permission.BOOKING_VIEW_ALL,
    Permission.BOOKING_CANCEL_ALL,
    Permission.CUSTOMER_VIEW_ALL,
    Permission.DRIVER_VIEW_ALL,
    Permission.DRIVER_APPROVE,
    Permission.DRIVER_SUSPEND,
    Permission.PRICING_VIEW,
    Permission.PRICING_MANAGE,
    Permission.PAYMENT_VIEW_ALL,
    Permission.PAYMENT_MANAGE,
    Permission.WALLET_VIEW_ALL,
    Permission.WALLET_MANAGE,
    Permission.RATING_VIEW_ALL,
    Permission.COUPON_VIEW,
    Permission.COUPON_MANAGE,
    Permission.SUPPORT_MANAGE,
    Permission.NOTIFICATION_SEND,
    Permission.REPORT_VIEW,
  ],
  [Role.SUPER_ADMIN]: Object.values(Permission),
};
