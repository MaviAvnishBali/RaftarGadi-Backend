import { SetMetadata } from '@nestjs/common';
import { Permission } from '../enums';

export const PERMISSIONS_KEY = 'permissions';

/**
 * Restricts endpoint access to users with specific permissions.
 * @example @Permissions(Permission.BOOKING_CREATE)
 */
export const Permissions = (...permissions: Permission[]): ReturnType<typeof SetMetadata> =>
  SetMetadata(PERMISSIONS_KEY, permissions);
