import { Injectable, Logger } from '@nestjs/common';
import { CustomersRepository } from '../repositories/customers.repository';
import { UpdateCustomerDto } from '../dto/update-customer.dto';
import { PaginationDto, PaginatedResponse } from '../../../common/dto/pagination.dto';
import { AppException } from '../../../common/exceptions/app.exception';

@Injectable()
export class CustomersService {
  private readonly logger = new Logger(CustomersService.name);

  constructor(private readonly customersRepo: CustomersRepository) {}

  async getProfile(userId: string) {
    const customer = await this.customersRepo.findByUserId(userId);
    if (!customer) throw new AppException('ERROR', 'Customer profile not found', 404);
    return customer;
  }

  async updateProfile(userId: string, dto: UpdateCustomerDto) {
    let customer = await this.customersRepo.findByUserId(userId);
    if (!customer) {
      customer = await this.customersRepo.create(userId, dto);
    } else {
      customer = await this.customersRepo.update(userId, dto);
    }
    return customer;
  }

  async findAll(query: PaginationDto) {
    return this.customersRepo.findAll(query);
  }

  async findById(id: string) {
    return this.customersRepo.findById(id);
  }
}
