import { Controller, Get, Patch, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { CustomersService } from '../services/customers.service';
import { UpdateCustomerDto } from '../dto/update-customer.dto';
import { PaginationDto } from '../../../common/dto/pagination.dto';
import { Roles, CurrentUser } from '../../../common/decorators';
import { Role } from '../../../common/enums';

@ApiTags('Customers')
@ApiBearerAuth('access-token')
@Controller({ path: 'customers', version: '1' })
export class CustomersController {
  constructor(private readonly customersService: CustomersService) {}

  @Get('profile')
  @Roles(Role.CUSTOMER)
  @ApiOperation({ summary: 'Get customer profile' })
  getProfile(@CurrentUser('sub') userId: string) {
    return this.customersService.getProfile(userId);
  }

  @Patch('profile')
  @Roles(Role.CUSTOMER)
  @ApiOperation({ summary: 'Update customer profile' })
  updateProfile(@CurrentUser('sub') userId: string, @Body() dto: UpdateCustomerDto) {
    return this.customersService.updateProfile(userId, dto);
  }

  @Get()
  @Roles(Role.ADMIN)
  @ApiOperation({ summary: 'List all customers (Admin)' })
  findAll(@Query() query: PaginationDto) {
    return this.customersService.findAll(query);
  }

  @Get(':id')
  @Roles(Role.ADMIN)
  @ApiOperation({ summary: 'Get customer by id (Admin)' })
  findById(@Param('id') id: string) {
    return this.customersService.findById(id);
  }
}
