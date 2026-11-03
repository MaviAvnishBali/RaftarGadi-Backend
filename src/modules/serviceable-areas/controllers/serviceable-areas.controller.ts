import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Body,
  Param,
  Query,
  HttpStatus,
  HttpCode,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { ServiceableAreasService } from '../services/serviceable-areas.service';
import { CreateServiceableAreaDto } from '../dto/create-serviceable-area.dto';
import { UpdateServiceableAreaDto } from '../dto/update-serviceable-area.dto';
import { CheckServiceabilityDto } from '../dto/check-serviceability.dto';
import { Public, Roles } from '../../../common/decorators';
import { Role } from '../../../common/enums';

@ApiTags('Serviceable Areas')
@ApiBearerAuth('access-token')
@Controller({ path: 'serviceable-areas', version: '1' })
export class ServiceableAreasController {
  constructor(private readonly areasService: ServiceableAreasService) {}

  @Public()
  @Get()
  @ApiOperation({ summary: 'List all serviceable operational areas' })
  @ApiResponse({ status: 200, description: 'List of operational areas returned successfully' })
  async listAreas(@Query('onlyActive') onlyActive?: string) {
    const filterActive = onlyActive === 'true' || onlyActive === '1';
    return this.areasService.findAll(filterActive);
  }

  @Public()
  @Get('check')
  @ApiOperation({ summary: 'Check if a GPS coordinate is within active serviceable areas' })
  @ApiResponse({ status: 200, description: 'Serviceability status returned' })
  async checkServiceability(@Query() query: CheckServiceabilityDto) {
    return this.areasService.checkLocationServiceability(
      Number(query.lat),
      Number(query.lng),
      query.address,
    );
  }

  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Get(':id')
  @ApiOperation({ summary: 'Get a serviceable area by ID (Admin only)' })
  async getAreaById(@Param('id') id: string) {
    return this.areasService.findById(id);
  }

  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Post()
  @HttpCode(HttpStatus.CREATED)
  @ApiOperation({ summary: 'Create a new serviceable area (Admin only)' })
  async createArea(@Body() dto: CreateServiceableAreaDto) {
    return this.areasService.createArea(dto);
  }

  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Patch(':id')
  @ApiOperation({ summary: 'Update an existing serviceable area (Admin only)' })
  async updateArea(@Param('id') id: string, @Body() dto: UpdateServiceableAreaDto) {
    return this.areasService.updateArea(id, dto);
  }

  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Patch(':id/toggle')
  @ApiOperation({ summary: 'Toggle active status of a serviceable area (Admin only)' })
  async toggleActive(@Param('id') id: string, @Body('isActive') isActive: boolean) {
    return this.areasService.toggleActive(id, isActive);
  }

  @Roles(Role.ADMIN, Role.SUPER_ADMIN)
  @Delete(':id')
  @ApiOperation({ summary: 'Delete a serviceable area (Admin only)' })
  async deleteArea(@Param('id') id: string) {
    return this.areasService.deleteArea(id);
  }
}
