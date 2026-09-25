import { Controller, Get, Post, Patch, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { DriversService } from '../services/drivers.service';
import { RegisterDriverDto } from '../dto/register-driver.dto';
import { UpdateDriverDto } from '../dto/update-driver.dto';
import { UploadDocumentDto } from '../dto/upload-document.dto';
import { DriverQueryDto } from '../dto/driver-query.dto';
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

  @Patch('profile')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Update driver profile' })
  updateProfile(@CurrentUser('sub') userId: string, @Body() dto: UpdateDriverDto) {
    return this.driversService.updateProfile(userId, dto);
  }

  @Post('go-online')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Go online' })
  async goOnline(@CurrentUser('sub') driverId: string) {
    await this.driversService.goOnline(driverId);
    return { success: true };
  }

  @Post('go-offline')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Go offline' })
  async goOffline(@CurrentUser('sub') driverId: string) {
    await this.driversService.goOffline(driverId);
    return { success: true };
  }

  @Post('documents')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Upload document' })
  uploadDocument(@CurrentUser('sub') driverId: string, @Body() dto: UploadDocumentDto) {
    return this.driversService.uploadDocument(driverId, dto);
  }

  @Get()
  @Roles(Role.ADMIN)
  @ApiOperation({ summary: 'List all drivers' })
  findAll(@Query() query: DriverQueryDto) {
    return this.driversService.findAll(query);
  }

  @Get(':id')
  @Roles(Role.ADMIN)
  @ApiOperation({ summary: 'Get driver by id' })
  findById(@Param('id') id: string) {
    return this.driversService.findById(id);
  }

  @Post(':id/approve')
  @Roles(Role.ADMIN)
  @Permissions(Permission.DRIVER_APPROVE)
  @ApiOperation({ summary: 'Approve driver KYC' })
  approveDriver(@Param('id') id: string) {
    return this.driversService.approveDriver(id);
  }

  @Post(':id/suspend')
  @Roles(Role.ADMIN)
  @Permissions(Permission.DRIVER_SUSPEND)
  @ApiOperation({ summary: 'Suspend driver' })
  suspendDriver(@Param('id') id: string, @Body('reason') reason: string) {
    return this.driversService.suspendDriver(id, reason);
  }
}
