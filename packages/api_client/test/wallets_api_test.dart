import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for WalletsApi
void main() {
  final instance = ApiClient().getWalletsApi();

  group(WalletsApi, () {
    // Admin view driver wallet transactions
    //
    //Future walletsControllerGetDriverTransactions(String driverId, { num page, num limit, String cursor, String type, String from, String to }) async
    test('test walletsControllerGetDriverTransactions', () async {
      // TODO
    });

    // Admin view driver wallet
    //
    //Future walletsControllerGetDriverWallet(String driverId) async
    test('test walletsControllerGetDriverWallet', () async {
      // TODO
    });

    // Get current driver wallet transactions
    //
    //Future walletsControllerGetMyTransactions({ num page, num limit, String cursor, String type, String from, String to }) async
    test('test walletsControllerGetMyTransactions', () async {
      // TODO
    });

    // Get current driver wallet
    //
    //Future walletsControllerGetMyWallet() async
    test('test walletsControllerGetMyWallet', () async {
      // TODO
    });

    // Request withdrawal
    //
    //Future walletsControllerRequestWithdrawal(WalletOperationDto walletOperationDto) async
    test('test walletsControllerRequestWithdrawal', () async {
      // TODO
    });

  });
}
