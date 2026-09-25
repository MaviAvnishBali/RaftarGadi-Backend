/// Build flavor for each app instance.
enum AppFlavor { development, staging, production }

/// Runtime configuration injected at app startup and read via Riverpod.
///
/// Everything a real backend integration will need (base URL, auth toggles)
/// is already modeled here, so switching from mock to live is a config change
/// rather than a code change. [useMockData] is the single switch the data
/// layer reads to decide between the fake and the real `ApiClient`.
class AppEnvironment {
  const AppEnvironment({
    required this.flavor,
    required this.apiBaseUrl,
    this.useMockData = true,
    this.simulatedLatency = const Duration(milliseconds: 600),
    this.simulatedFailureRate = 0,
  });

  factory AppEnvironment.development() => const AppEnvironment(
    flavor: AppFlavor.development,
    apiBaseUrl: 'https://dev.api.raftargaddi.local',
  );

  final AppFlavor flavor;
  final String apiBaseUrl;

  /// When true, repositories resolve to the in-memory fake data source.
  final bool useMockData;

  /// Artificial delay the fake API applies to mimic network round-trips.
  final Duration simulatedLatency;

  /// Probability [0.0–1.0] that the fake API injects a `NetworkFailure`,
  /// used to exercise error and retry UI paths.
  final double simulatedFailureRate;

  bool get isProduction => flavor == AppFlavor.production;
}
