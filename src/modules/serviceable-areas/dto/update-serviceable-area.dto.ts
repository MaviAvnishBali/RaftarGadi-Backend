import { PartialType } from '@nestjs/swagger';
import { CreateServiceableAreaDto } from './create-serviceable-area.dto';

export class UpdateServiceableAreaDto extends PartialType(CreateServiceableAreaDto) {}
