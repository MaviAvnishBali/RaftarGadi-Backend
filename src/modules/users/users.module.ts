import { Module } from '@nestjs/common';
import { UsersService } from './services/users.service';
import { UsersRepository } from './repositories/users.repository';
import { PrismaService } from '@database/prisma.service';

@Module({
  providers: [UsersService, UsersRepository, PrismaService],
  exports: [UsersService],
})
export class UsersModule {}
