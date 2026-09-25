import { SetMetadata } from '@nestjs/common';
import { Role } from '../enums';

export const ROLES_KEY = 'roles';

/**
 * Restricts endpoint access to specific roles.
 * @example @Roles(Role.ADMIN, Role.SUPER_ADMIN)
 */
export const Roles = (...roles: Role[]): ReturnType<typeof SetMetadata> =>
  SetMetadata(ROLES_KEY, roles);
