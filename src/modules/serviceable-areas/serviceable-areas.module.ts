import { Module } from '@nestjs/common';
import { ServiceableAreasController } from './controllers/serviceable-areas.controller';
import { ServiceableAreasService } from './services/serviceable-areas.service';
import { PrismaService } from '../../database/prisma.service';

@Module({
  controllers: [ServiceableAreasController],
  providers: [ServiceableAreasService, PrismaService],
  exports: [ServiceableAreasService],
})
export class ServiceableAreasModule {}
