import { Controller, Post, Body, Get, Req, Ip } from '@nestjs/common';
import { AuthService } from '../services/auth.service';
import { SendOtpDto } from '../dto/send-otp.dto';
import { VerifyOtpDto } from '../dto/verify-otp.dto';
import { RefreshTokenDto } from '../dto/refresh-token.dto';
import { Public, CurrentUser } from '@common/decorators';
import { ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';

@ApiTags('Auth')
@Controller({ version: '1', path: 'auth' })
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Public()
  @Post('send-otp')
  @ApiOperation({ summary: 'Send OTP to phone' })
  @ApiResponse({ status: 200, description: 'OTP sent successfully' })
  async sendOtp(@Body() sendOtpDto: SendOtpDto) {
    return this.authService.sendOtp(sendOtpDto.phone);
  }

  @Public()
  @Post('verify-otp')
  @ApiOperation({ summary: 'Verify OTP and login' })
  @ApiResponse({ status: 200, description: 'User authenticated successfully' })
  async verifyOtp(@Body() verifyOtpDto: VerifyOtpDto, @Ip() ip: string) {
    return this.authService.verifyOtp(
      verifyOtpDto.phone,
      verifyOtpDto.otp,
      verifyOtpDto.role as any,
      verifyOtpDto.deviceInfo,
      ip,
    );
  }

  @Public()
  @Post('refresh')
  @ApiOperation({ summary: 'Refresh access token' })
  @ApiResponse({ status: 200, description: 'Tokens refreshed' })
  async refreshTokens(@Body() refreshTokenDto: RefreshTokenDto, @Ip() ip: string, @Req() req: any) {
    const deviceInfo = req.headers['user-agent'];
    return this.authService.refreshTokens(refreshTokenDto.refreshToken, deviceInfo, ip);
  }

  @Post('logout')
  @ApiOperation({ summary: 'Logout user from current device' })
  @ApiResponse({ status: 200, description: 'Logged out successfully' })
  async logout(@CurrentUser('sub') userId: string, @Body() refreshTokenDto: RefreshTokenDto) {
    return this.authService.logout(userId, refreshTokenDto.refreshToken);
  }

  @Post('logout-all')
  @ApiOperation({ summary: 'Logout user from all devices' })
  @ApiResponse({ status: 200, description: 'Logged out from all devices successfully' })
  async logoutAll(@CurrentUser('sub') userId: string) {
    return this.authService.logoutAll(userId);
  }

  @Get('me')
  @ApiOperation({ summary: 'Get current user profile' })
  @ApiResponse({ status: 200, description: 'Returns current user profile' })
  async getMe(@CurrentUser() user: any) {
    return user;
  }
}
