/// Raftar Gaddi — `core` package.
///
/// Cross-cutting foundation shared by every app and package: configuration,
/// the transport abstraction, dependency-injection providers, and the
/// Result/Failure error model. This is the only package all others may depend
/// on for infrastructure.
library;

export 'src/config/app_environment.dart';
export 'src/di/providers.dart';
export 'src/geo/route_service.dart';
export 'src/network/api_client.dart';
export 'src/network/fake_api_client.dart';
export 'src/result/failure.dart';
export 'src/result/result.dart';
