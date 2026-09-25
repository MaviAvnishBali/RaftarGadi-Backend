import { PartialType } from '@nestjs/swagger';
import { RegisterVehicleDto } from './register-vehicle.dto';

export class UpdateVehicleDto extends PartialType(RegisterVehicleDto) {}
