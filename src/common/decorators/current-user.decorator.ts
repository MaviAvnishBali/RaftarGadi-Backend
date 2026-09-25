import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { Request } from 'express';

export interface JwtPayload {
  sub: string;
  role: string;
  phone: string;
  iat?: number;
  exp?: number;
}

/**
 * Extracts the authenticated user from the request.
 * @example @CurrentUser() user: JwtPayload
 * @example @CurrentUser('sub') userId: string
 */
export const CurrentUser = createParamDecorator(
  (data: keyof JwtPayload | undefined, ctx: ExecutionContext): JwtPayload | string => {
    const request = ctx.switchToHttp().getRequest<Request>();
    const user = request.user as JwtPayload;
    return data ? (user?.[data] as any) : user;
  },
);
