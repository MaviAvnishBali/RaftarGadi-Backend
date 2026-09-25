import { Injectable } from '@nestjs/common';
import { UsersRepository } from '../repositories/users.repository';
import { UpdateUserDto } from '../dto/update-user.dto';
import { User } from '@prisma/client';
import { Role } from '@common/enums';

@Injectable()
export class UsersService {
  constructor(private readonly usersRepository: UsersRepository) {}

  async findById(id: string): Promise<User | null> {
    return this.usersRepository.findById(id);
  }

  async findByPhone(phone: string): Promise<User | null> {
    return this.usersRepository.findByPhone(phone);
  }

  async findOrCreateByPhone(phone: string, role: Role): Promise<User> {
    let user = await this.findByPhone(phone);
    if (!user) {
      user = await this.usersRepository.create({ phone, role });
    }
    return user;
  }

  async updateProfile(id: string, data: UpdateUserDto): Promise<User> {
    return this.usersRepository.update(id, data);
  }

  async updateFcmToken(id: string, token: string): Promise<void> {
    await this.usersRepository.update(id, { fcmToken: token } as any);
  }

  async deactivateUser(id: string): Promise<void> {
    await this.usersRepository.update(id, { isActive: false } as any);
  }
}
