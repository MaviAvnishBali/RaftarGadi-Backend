import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import { Request, Response } from 'express';

interface ErrorBody {
  code?: string;
  message?: string;
  details?: unknown[];
}

@Catch()
export class GlobalExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger(GlobalExceptionFilter.name);

  catch(exception: unknown, host: ArgumentsHost): void {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();

    let statusCode: number;
    let errorCode: string;
    let message: string;
    let details: unknown[] | undefined;

    if (exception instanceof HttpException) {
      statusCode = exception.getStatus();
      const exceptionResponse = exception.getResponse();

      if (typeof exceptionResponse === 'object' && exceptionResponse !== null) {
        const body = exceptionResponse as ErrorBody;
        errorCode = body.code || this.getDefaultErrorCode(statusCode);
        message = body.message || exception.message;
        details = body.details;
      } else {
        errorCode = this.getDefaultErrorCode(statusCode);
        message = typeof exceptionResponse === 'string' ? exceptionResponse : exception.message;
      }
    } else if (exception instanceof Error) {
      statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
      errorCode = 'SYSTEM_INTERNAL_ERROR';
      message = 'An unexpected error occurred';

      // Log the full error internally but don't expose to client
      this.logger.error(
        {
          requestId: (request as unknown as Record<string, unknown>).id,
          error: exception.message,
          stack: exception.stack,
          path: request.url,
          method: request.method,
        },
        'Unhandled exception',
      );
    } else {
      statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
      errorCode = 'SYSTEM_UNKNOWN_ERROR';
      message = 'An unknown error occurred';
    }

    const errorResponse = {
      success: false,
      error: {
        code: errorCode,
        message,
        ...(details && { details }),
      },
      requestId: (request as unknown as Record<string, unknown>).id || 'unknown',
      timestamp: new Date().toISOString(),
    };

    // Log non-500 errors at warn level
    if (statusCode >= 500) {
      this.logger.error(
        { statusCode, errorCode, path: request.url, method: request.method },
        message,
      );
    } else if (statusCode >= 400) {
      this.logger.warn(
        { statusCode, errorCode, path: request.url, method: request.method },
        message,
      );
    }

    response.status(statusCode).json(errorResponse);
  }

  private getDefaultErrorCode(statusCode: number): string {
    switch (statusCode) {
      case 400:
        return 'VALIDATION_ERROR';
      case 401:
        return 'AUTH_UNAUTHORIZED';
      case 403:
        return 'AUTHZ_FORBIDDEN';
      case 404:
        return 'NOT_FOUND';
      case 409:
        return 'CONFLICT';
      case 429:
        return 'RATE_LIMIT_EXCEEDED';
      default:
        return 'SYSTEM_ERROR';
    }
  }
}
