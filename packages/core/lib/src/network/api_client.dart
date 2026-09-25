/// Transport-agnostic HTTP contract the data layer depends on.
///
/// Repositories are written against this interface only. The Phase-0 default
/// binding is `FakeApiClient`; a real Dio/http implementation can be dropped
/// in later by overriding a single Riverpod provider, with zero changes to
/// repositories, business logic, or UI.
abstract interface class ApiClient {
  Future<Json> get(String path, {Query? query});

  Future<Json> post(String path, {Object? body});

  Future<Json> put(String path, {Object? body});

  Future<Json> delete(String path, {Object? body});
}

/// A decoded JSON object.
typedef Json = Map<String, dynamic>;

/// Query-string parameters for a request.
typedef Query = Map<String, dynamic>;
