import { Controller, Post, Get, Body, Param, Query, HttpCode, HttpStatus } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { WalletsService } from '../services/wallets.service';
import { WalletQueryDto } from '../dto/wallet-query.dto';
import { WalletOperationDto } from '../dto/wallet-operation.dto';
import { Roles, CurrentUser } from '../../../common/decorators';
import { Role } from '../../../common/enums';

@ApiTags('Wallets')
@ApiBearerAuth('access-token')
@Controller({ path: 'wallets', version: '1' })
export class WalletsController {
  constructor(private readonly walletsService: WalletsService) {}

  @Roles(Role.DRIVER)
  @Get('my-wallet')
  @ApiOperation({ summary: 'Get current driver wallet' })
  async getMyWallet(@CurrentUser('sub') driverId: string) {
    return this.walletsService.getOrCreateWallet(driverId);
  }

  @Roles(Role.DRIVER)
  @Get('my-wallet/transactions')
  @ApiOperation({ summary: 'Get current driver wallet transactions' })
  async getMyTransactions(@CurrentUser('sub') driverId: string, @Query() query: WalletQueryDto) {
    const wallet = await this.walletsService.getOrCreateWallet(driverId);
    return this.walletsService.getTransactions(wallet.id, query);
  }

  @Roles(Role.DRIVER)
  @Post('withdraw')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Request withdrawal' })
  async requestWithdrawal(@CurrentUser('sub') driverId: string, @Body() dto: WalletOperationDto) {
    return this.walletsService.processWithdrawal(driverId, dto.amount);
  }

  @Roles(Role.ADMIN)
  @Get('driver/:driverId')
  @ApiOperation({ summary: 'Admin view driver wallet' })
  async getDriverWallet(@Param('driverId') driverId: string) {
    return this.walletsService.getWallet(driverId);
  }

  @Roles(Role.ADMIN)
  @Get('driver/:driverId/transactions')
  @ApiOperation({ summary: 'Admin view driver wallet transactions' })
  async getDriverTransactions(@Param('driverId') driverId: string, @Query() query: WalletQueryDto) {
    const wallet = await this.walletsService.getWallet(driverId);
    return this.walletsService.getTransactions(wallet.id, query);
  }
}
