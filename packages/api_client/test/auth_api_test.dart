import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AuthApi
void main() {
  final instance = ApiClient().getAuthApi();

  group(AuthApi, () {
    // Get current user profile
    //
    //Future authControllerGetMe() async
    test('test authControllerGetMe', () async {
      // TODO
    });

    // Logout user from current device
    //
    //Future authControllerLogout(RefreshTokenDto refreshTokenDto) async
    test('test authControllerLogout', () async {
      // TODO
    });

    // Logout user from all devices
    //
    //Future authControllerLogoutAll() async
    test('test authControllerLogoutAll', () async {
      // TODO
    });

    // Refresh access token
    //
    //Future authControllerRefreshTokens(RefreshTokenDto refreshTokenDto) async
    test('test authControllerRefreshTokens', () async {
      // TODO
    });

    // Send OTP to phone
    //
    //Future authControllerSendOtp(SendOtpDto sendOtpDto) async
    test('test authControllerSendOtp', () async {
      // TODO
    });

    // Verify OTP and login
    //
    //Future authControllerVerifyOtp(VerifyOtpDto verifyOtpDto) async
    test('test authControllerVerifyOtp', () async {
      // TODO
    });

  });
}
