import { Controller, Get, Post, Patch, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { DriversService } from '../services/drivers.service';
import { RegisterDriverDto } from '../dto/register-driver.dto';
import { UpdateDriverDto } from '../dto/update-driver.dto';
import { UploadDocumentDto } from '../dto/upload-document.dto';
import { DriverQueryDto } from '../dto/driver-query.dto';
import { VerifyLicenseDto } from '../dto/verify-license.dto';
import { SubmitKycDto } from '../dto/submit-kyc.dto';
import { Roles, Permissions, CurrentUser } from '../../../common/decorators';
import { Role, Permission } from '../../../common/enums';

@ApiTags('Drivers')
@ApiBearerAuth('access-token')
@Controller({ path: 'drivers', version: '1' })
export class DriversController {
  constructor(private readonly driversService: DriversService) {}

  @Post('register')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Register as driver' })
  registerDriver(@CurrentUser('sub') userId: string, @Body() dto: RegisterDriverDto) {
    return this.driversService.registerDriver(userId, dto);
  }

  @Get('profile')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Get own driver profile' })
  getProfile(@CurrentUser('sub') userId: string) {
    return this.driversService.getProfile(userId);
  }

  @Get('dashboard')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Get driver home dashboard data' })
  getDashboard(@CurrentUser('sub') userId: string) {
    return this.driversService.getDashboard(userId);
  }

  @Patch('profile')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Update driver profile' })
  updateProfile(@CurrentUser('sub') userId: string, @Body() dto: UpdateDriverDto) {
    return this.driversService.updateProfile(userId, dto);
  }

  @Post('go-online')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Go online' })
  async goOnline(@CurrentUser('sub') userId: string) {
    return this.driversService.goOnline(userId);
  }

  @Post('go-offline')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Go offline' })
  async goOffline(@CurrentUser('sub') userId: string) {
    return this.driversService.goOffline(userId);
  }

  @Post('documents')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Upload document' })
  uploadDocument(@CurrentUser('sub') driverId: string, @Body() dto: UploadDocumentDto) {
    return this.driversService.uploadDocument(driverId, dto);
  }

  @Post('verify-license')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Verify and save driving license' })
  verifyLicense(@CurrentUser('sub') userId: string, @Body() dto: VerifyLicenseDto) {
    return this.driversService.verifyAndSaveLicense(userId, dto.licenseNumber);
  }

  @Post('kyc-details')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Submit driving license and Aadhaar details for KYC' })
  submitKyc(@CurrentUser('sub') userId: string, @Body() dto: SubmitKycDto) {
    return this.driversService.submitKycDetails(userId, dto);
  }

  @Get()
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @ApiOperation({ summary: 'List all drivers' })
  findAll(@Query() query: DriverQueryDto) {
    return this.driversService.findAll(query);
  }

  @Get(':id')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @ApiOperation({ summary: 'Get driver by id' })
  findById(@Param('id') id: string) {
    return this.driversService.findById(id);
  }

  @Post(':id/approve')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Permissions(Permission.DRIVER_APPROVE)
  @ApiOperation({ summary: 'Approve driver KYC' })
  approveDriver(@Param('id') id: string) {
    return this.driversService.approveDriver(id);
  }

  @Post(':id/suspend')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Permissions(Permission.DRIVER_SUSPEND)
  @ApiOperation({ summary: 'Suspend driver' })
  suspendDriver(@Param('id') id: string, @Body('reason') reason: string) {
    return this.driversService.suspendDriver(id, reason);
  }
}
