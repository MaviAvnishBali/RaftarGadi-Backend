import { Controller, Get, Post, Param, Query, Version, Req } from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { Roles, CurrentUser } from '../../../common/decorators';
import { Role } from '../../../common/enums';
import { AdminService } from '../services/admin.service';
import { AuditLogQueryDto } from '../dto/audit-log-query.dto';

@ApiTags('Admin')
@ApiBearerAuth('access-token')
@Controller('admin')
export class AdminController {
  constructor(private readonly adminService: AdminService) {}

  @Version('1')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Get('overview')
  async getOverview() {
    return this.adminService.getOverview();
  }

  @Version('1')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Post('users/:id/activate')
  async activateUser(@Param('id') id: string, @CurrentUser() user: any, @Req() req: any) {
    const result = await this.adminService.manageUser(id, 'activate');
    await this.adminService.auditLog(
      user.id,
      user.role,
      'ACTIVATE_USER',
      'USER',
      id,
      { active: false },
      { active: true },
      req.ip,
      req.headers['user-agent'],
    );
    return result;
  }

  @Version('1')
  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Post('users/:id/deactivate')
  async deactivateUser(@Param('id') id: string, @CurrentUser() user: any, @Req() req: any) {
    const result = await this.adminService.manageUser(id, 'deactivate');
    await this.adminService.auditLog(
      user.id,
      user.role,
      'DEACTIVATE_USER',
      'USER',
      id,
      { active: true },
      { active: false },
      req.ip,
      req.headers['user-agent'],
    );
    return result;
  }

  @Version('1')
  @Roles(Role.SUPER_ADMIN)
  @Get('audit-logs')
  async getAuditLogs(@Query() query: AuditLogQueryDto) {
    return this.adminService.getAuditLogs(query);
  }
}
