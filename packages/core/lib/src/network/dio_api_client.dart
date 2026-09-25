import 'package:api_client/api_client.dart' as gen;
import 'package:dio/dio.dart';
import 'api_client.dart';

/// A real ApiClient implementation wrapping the generated OpenAPI client.
class DioApiClient implements ApiClient {
  final gen.ApiClient _generatedClient;
  
  DioApiClient(this._generatedClient);

  @override
  Future<Json> get(String path, {Query? query}) async {
    final response = await _generatedClient.dio.get(path, queryParameters: query);
    return response.data as Json;
  }

  @override
  Future<Json> post(String path, {Object? body}) async {
    final response = await _generatedClient.dio.post(path, data: body);
    return response.data as Json;
  }

  @override
  Future<Json> put(String path, {Object? body}) async {
    final response = await _generatedClient.dio.put(path, data: body);
    return response.data as Json;
  }

  @override
  Future<Json> delete(String path, {Object? body}) async {
    final response = await _generatedClient.dio.delete(path, data: body);
    return response.data as Json;
  }
}
