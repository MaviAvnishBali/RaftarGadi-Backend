import { UserRole } from '@prisma/client';
import { RolesGuard } from '../roles.guard';
import { Reflector } from '@nestjs/core';
import { ExecutionContext } from '@nestjs/common';
import { Role } from '../../enums';
import { AppException } from '../../exceptions';

describe('RolesGuard', () => {
  let guard: RolesGuard;
  let reflector: Reflector;
  let mockContext: Partial<ExecutionContext>;
  let mockRequest: any;

  beforeEach(() => {
    reflector = new Reflector();
    guard = new RolesGuard(reflector);

    mockRequest = { user: null };
    mockContext = {
      getHandler: jest.fn(),
      getClass: jest.fn(),
      switchToHttp: jest.fn().mockReturnValue({
        getRequest: () => mockRequest,
      }),
    };
  });

  it('should bypass for @Public() routes', () => {
    jest.spyOn(reflector, 'getAllAndOverride').mockReturnValueOnce(true); // isPublic = true
    expect(guard.canActivate(mockContext as ExecutionContext)).toBe(true);
  });

  it('should allow access when no roles are required', () => {
    jest
      .spyOn(reflector, 'getAllAndOverride')
      .mockReturnValueOnce(false) // isPublic = false
      .mockReturnValueOnce([]); // requiredRoles = empty

    expect(guard.canActivate(mockContext as ExecutionContext)).toBe(true);
  });

  it('should throw unauthorized if user is not present', () => {
    jest
      .spyOn(reflector, 'getAllAndOverride')
      .mockReturnValueOnce(false) // isPublic = false
      .mockReturnValueOnce([Role.ADMIN]); // requiredRoles = ADMIN

    expect(() => guard.canActivate(mockContext as ExecutionContext)).toThrow(AppException);
  });

  it('should allow access for matching role', () => {
    jest
      .spyOn(reflector, 'getAllAndOverride')
      .mockReturnValueOnce(false)
      .mockReturnValueOnce([Role.ADMIN, UserRole.CUSTOMER]);

    mockRequest.user = { role: Role.ADMIN };

    expect(guard.canActivate(mockContext as ExecutionContext)).toBe(true);
  });

  it('should deny access for non-matching role', () => {
    jest
      .spyOn(reflector, 'getAllAndOverride')
      .mockReturnValueOnce(false)
      .mockReturnValueOnce([Role.ADMIN]);

    mockRequest.user = { role: UserRole.CUSTOMER };

    expect(() => guard.canActivate(mockContext as ExecutionContext)).toThrow(AppException);
  });
});
