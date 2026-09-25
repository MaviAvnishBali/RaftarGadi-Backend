import { PermissionsGuard } from '../permissions.guard';
import { Reflector } from '@nestjs/core';
import { ExecutionContext } from '@nestjs/common';
import { Permission, Role, ROLE_PERMISSIONS } from '../../enums';
import { AppException } from '../../exceptions';

describe('PermissionsGuard', () => {
  let guard: PermissionsGuard;
  let reflector: Reflector;
  let mockContext: Partial<ExecutionContext>;
  let mockRequest: any;

  beforeEach(() => {
    reflector = new Reflector();
    guard = new PermissionsGuard(reflector);

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
    jest.spyOn(reflector, 'getAllAndOverride').mockReturnValueOnce(true);
    expect(guard.canActivate(mockContext as ExecutionContext)).toBe(true);
  });

  it('should allow access when no permissions are required', () => {
    jest.spyOn(reflector, 'getAllAndOverride').mockReturnValueOnce(false).mockReturnValueOnce([]);

    expect(guard.canActivate(mockContext as ExecutionContext)).toBe(true);
  });

  it('should throw unauthorized if user is not present', () => {
    jest
      .spyOn(reflector, 'getAllAndOverride')
      .mockReturnValueOnce(false)
      .mockReturnValueOnce(['some_permission' as Permission]);

    expect(() => guard.canActivate(mockContext as ExecutionContext)).toThrow(AppException);
  });

  it('should allow access when user has required permission', () => {
    const mockRole = 'TEST_ROLE' as Role;
    const requiredPermission = 'READ_DATA' as Permission;

    // Setup ROLE_PERMISSIONS mock for testing
    (ROLE_PERMISSIONS as any)[mockRole] = [requiredPermission, 'OTHER_PERM'];

    jest
      .spyOn(reflector, 'getAllAndOverride')
      .mockReturnValueOnce(false)
      .mockReturnValueOnce([requiredPermission]);

    mockRequest.user = { role: mockRole };

    expect(guard.canActivate(mockContext as ExecutionContext)).toBe(true);
  });

  it('should deny access when user lacks required permission', () => {
    const mockRole = 'TEST_ROLE' as Role;

    // Setup ROLE_PERMISSIONS mock for testing
    (ROLE_PERMISSIONS as any)[mockRole] = ['OTHER_PERM'];

    jest
      .spyOn(reflector, 'getAllAndOverride')
      .mockReturnValueOnce(false)
      .mockReturnValueOnce(['READ_DATA' as Permission]);

    mockRequest.user = { role: mockRole };

    expect(() => guard.canActivate(mockContext as ExecutionContext)).toThrow(AppException);
  });

  it('should deny access if multiple permissions required and user lacks one', () => {
    const mockRole = 'TEST_ROLE' as Role;

    // Setup ROLE_PERMISSIONS mock for testing
    (ROLE_PERMISSIONS as any)[mockRole] = ['READ_DATA'];

    jest
      .spyOn(reflector, 'getAllAndOverride')
      .mockReturnValueOnce(false)
      .mockReturnValueOnce(['READ_DATA' as Permission, 'WRITE_DATA' as Permission]);

    mockRequest.user = { role: mockRole };

    expect(() => guard.canActivate(mockContext as ExecutionContext)).toThrow(AppException);
  });
});
