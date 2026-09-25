import 'package:core/src/config/app_environment.dart';
import 'package:core/src/geo/route_service.dart';
import 'package:core/src/network/api_client.dart';
import 'package:core/src/network/fake_api_client.dart';
import 'package:core/src/network/dio_api_client.dart';
import 'package:api_client/api_client.dart' as gen;
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Root configuration provider. Each app overrides this in its `ProviderScope`
/// with its own flavor (development/staging/production).
final appEnvironmentProvider = Provider<AppEnvironment>(
  (ref) => AppEnvironment.development(),
);

/// The single injection point for the transport layer. Swapping to a real client later is one override here.
final apiClientProvider = Provider<ApiClient>((ref) {
  final environment = ref.watch(appEnvironmentProvider);
  // Point to the live backend running locally. (Requires adb reverse tcp:3000 tcp:3000 for physical devices)
  final dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:3000')); 
  
  // Add logging interceptor so the user can see API requests and responses in console
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  final generatedClient = gen.ApiClient(dio: dio);
  return DioApiClient(generatedClient);
});

/// Routing/distance service. Bound to the mock (straight-line) implementation
/// today; swap to a real routing API here without touching callers.
final routeServiceProvider = Provider<RouteService>(
  (ref) => const MockRouteService(),
);
