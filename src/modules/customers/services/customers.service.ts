import { Injectable, Logger } from '@nestjs/common';
import { CustomersRepository } from '../repositories/customers.repository';
import { UpdateCustomerDto } from '../dto/update-customer.dto';
import { CustomerQueryDto } from '../dto/customer-query.dto';
import { AppException } from '../../../common/exceptions/app.exception';

@Injectable()
export class CustomersService {
  private readonly logger = new Logger(CustomersService.name);

  constructor(private readonly customersRepo: CustomersRepository) {}

  async getProfile(userId: string) {
    let customer = await this.customersRepo.findByUserId(userId);
    if (!customer) {
      const user = await this.customersRepo.findUserById(userId);
      if (!user) throw new AppException('ERROR', 'User not found', 404);
      customer = await this.customersRepo.create(userId, {});
    }
    return customer;
  }

  async updateProfile(userId: string, dto: UpdateCustomerDto) {
    if (dto.name !== undefined || dto.email !== undefined) {
      const userData: { name?: string; email?: string } = {};
      if (dto.name !== undefined) userData.name = dto.name;
      if (dto.email !== undefined) userData.email = dto.email;
      await this.customersRepo.updateUser(userId, userData);
    }

    let customer = await this.customersRepo.findByUserId(userId);
    if (!customer) {
      customer = await this.customersRepo.create(userId, dto);
    } else {
      customer = await this.customersRepo.update(userId, dto);
    }
    return this.customersRepo.findByUserId(userId);
  }

  async findAll(query: CustomerQueryDto) {
    return this.customersRepo.findAll(query);
  }

  async findById(id: string) {
    return this.customersRepo.findById(id);
  }
}
