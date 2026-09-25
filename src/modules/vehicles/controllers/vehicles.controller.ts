import { Controller, Get, Post, Patch, Body, Param } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { VehiclesService } from '../services/vehicles.service';
import { CreateVehicleTypeDto } from '../dto/create-vehicle-type.dto';
import { RegisterVehicleDto } from '../dto/register-vehicle.dto';
import { UpdateVehicleDto } from '../dto/update-vehicle.dto';
import { Public, Roles, CurrentUser } from '../../../common/decorators';
import { Role } from '../../../common/enums';

@ApiTags('Vehicles')
@ApiBearerAuth('access-token')
@Controller({ path: 'vehicles', version: '1' })
export class VehiclesController {
  constructor(private readonly vehiclesService: VehiclesService) {}

  @Get('types')
  @Public()
  @ApiOperation({ summary: 'List vehicle types' })
  getVehicleTypes() {
    return this.vehiclesService.getVehicleTypes();
  }

  @Post('types')
  @Roles(Role.ADMIN)
  @ApiOperation({ summary: 'Create vehicle type' })
  createVehicleType(@Body() dto: CreateVehicleTypeDto) {
    return this.vehiclesService.createVehicleType(dto);
  }

  @Post('register')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Register vehicle' })
  registerVehicle(@CurrentUser('sub') driverId: string, @Body() dto: RegisterVehicleDto) {
    return this.vehiclesService.registerVehicle(driverId, dto);
  }

  @Get('my-vehicle')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Get own vehicle' })
  getDriverVehicle(@CurrentUser('sub') driverId: string) {
    return this.vehiclesService.getDriverVehicle(driverId);
  }

  @Patch(':id')
  @Roles(Role.DRIVER)
  @ApiOperation({ summary: 'Update vehicle' })
  updateVehicle(@Param('id') id: string, @Body() dto: UpdateVehicleDto) {
    return this.vehiclesService.updateVehicle(id, dto);
  }
}
