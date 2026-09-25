import 'package:core/core.dart';
import 'package:shared_models/shared_models.dart';

/// Contract for authentication. UI and controllers depend only on this; the
/// binding (mock today, real API later) is chosen in the provider.
abstract interface class AuthRepository {
  /// Creates an account, then sends an OTP to verify its phone number.
  Future<Result<void>> register({
    required String fullName,
    required String phone,
    String? email,
  });

  Future<Result<void>> requestOtp(String phone);

  Future<Result<AppUser>> verifyOtp({
    required String phone,
    required String otp,
    String role = 'CUSTOMER',
  });
}

/// [ApiClient]-backed implementation. Identical against mock or real transport.
class ApiAuthRepository implements AuthRepository {
  ApiAuthRepository(this._api);

  final ApiClient _api;

  @override
  Future<Result<void>> register({
    required String fullName,
    required String phone,
    String? email,
  }) => guardAsync(() async {
    // The backend handles registration natively in verify-otp.
    // So for "register", we just send the OTP to start the flow.
    await _api.post(
      '/api/v1/auth/send-otp',
      body: {'phone': phone},
    );
  });

  @override
  Future<Result<void>> requestOtp(String phone) => guardAsync(() async {
    await _api.post('/api/v1/auth/send-otp', body: {'phone': phone});
  });

  @override
  Future<Result<AppUser>> verifyOtp({
    required String phone,
    required String otp,
    String role = 'CUSTOMER',
  }) => guardAsync(() async {
    final json = await _api.post(
      '/api/v1/auth/verify-otp',
      body: {'phone': phone, 'otp': otp, 'role': role},
    );
    // NestJS backend returns { user: {...}, accessToken, refreshToken }
    return AppUser.fromJson(json['user'] as Map<String, dynamic>);
  });
}
