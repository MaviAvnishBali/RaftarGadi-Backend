import 'package:core/core.dart';
import 'package:shared_models/shared_models.dart';

/// Contract for reading the current user's wallet.
abstract interface class WalletRepository {
  Future<Result<Wallet>> getWallet(String ownerId);
}

/// [ApiClient]-backed implementation.
class ApiWalletRepository implements WalletRepository {
  ApiWalletRepository(this._api);

  final ApiClient _api;

  @override
  Future<Result<Wallet>> getWallet(String ownerId) => guardAsync(() async {
    final json = await _api.get('/wallet', query: {'ownerId': ownerId});
    return Wallet.fromJson(json['wallet'] as Map<String, dynamic>);
  });
}
