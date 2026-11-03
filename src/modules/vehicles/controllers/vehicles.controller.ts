import { Controller, Get, Post, Patch, Body, Param, Query, ParseFloatPipe } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { VehiclesService } from '../services/vehicles.service';
import { CreateVehicleTypeDto } from '../dto/create-vehicle-type.dto';
import { RegisterVehicleDto } from '../dto/register-vehicle.dto';
import { UpdateVehicleDto } from '../dto/update-vehicle.dto';
import { Public, Roles, CurrentUser, Permissions } from '../../../common/decorators';
import { Role, Permission } from '../../../common/enums';

@ApiTags('Vehicles')
@ApiBearerAuth('access-token')
@Controller({ path: 'vehicles', version: '1' })
export class VehiclesController {
  constructor(private readonly vehiclesService: VehiclesService) {}

  @Get('available-nearby')
  @Public()
  @ApiOperation({ summary: 'Get available vehicles nearby within progressive 10km -> 15km -> 25km geofence' })
  @ApiQuery({ name: 'lat', type: Number, description: 'Customer current or pickup latitude' })
  @ApiQuery({ name: 'lng', type: Number, description: 'Customer current or pickup longitude' })
  getAvailableVehiclesNearby(
    @Query('lat', ParseFloatPipe) lat: number,
    @Query('lng', ParseFloatPipe) lng: number,
  ) {
    return this.vehiclesService.findAvailableVehiclesNearby(lat, lng);
  }

  @Get('types')
  @Public()
  @ApiOperation({ summary: 'List vehicle types' })
  getVehicleTypes() {
    return this.vehiclesService.getVehicleTypes();
  }

  @Post('types')
  @Permissions(Permission.PRICING_MANAGE)
  @Roles(Role.ADMIN)
  @ApiOperation({ summary: 'Create vehicle type' })
  createVehicleType(@Body() dto: CreateVehicleTypeDto) {
    return this.vehiclesService.createVehicleType(dto);
  }

  @Patch('types/:id')
  @Permissions(Permission.PRICING_MANAGE)
  @Roles(Role.ADMIN)
  @ApiOperation({ summary: 'Update vehicle type dimensions and specs' })
  updateVehicleType(@Param('id') id: string, @Body() dto: Partial<CreateVehicleTypeDto>) {
    return this.vehiclesService.updateVehicleType(id, dto);
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
