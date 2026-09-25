/// Raftar Gaddi — `mock_data` package.
///
/// The fake API: an in-memory database plus route handlers registered on
/// `FakeApiClient`. It simulates latency (via the client), pagination, search,
/// and resource creation. Apps call `registerMockRoutes` at bootstrap; nothing
/// outside this package depends on the mock data itself.
library;

export 'src/fixtures/seed_data.dart';
export 'src/mock_database.dart';
export 'src/register_mock_routes.dart';
