import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminApi
void main() {
  final instance = ApiClient().getAdminApi();

  group(AdminApi, () {
    //Future adminControllerActivateUser(String id) async
    test('test adminControllerActivateUser', () async {
      // TODO
    });

    //Future adminControllerDeactivateUser(String id) async
    test('test adminControllerDeactivateUser', () async {
      // TODO
    });

    //Future adminControllerGetAuditLogs({ String page, String limit, String actorId, String action, String entityType, String entityId, String from, String to }) async
    test('test adminControllerGetAuditLogs', () async {
      // TODO
    });

    //Future<JsonObject> adminControllerGetOverview() async
    test('test adminControllerGetOverview', () async {
      // TODO
    });

    //Future<BuiltList<JsonObject>> reportsControllerGetBookingTrends({ String from, String to, String interval }) async
    test('test reportsControllerGetBookingTrends', () async {
      // TODO
    });

    //Future<JsonObject> reportsControllerGetDashboardStats() async
    test('test reportsControllerGetDashboardStats', () async {
      // TODO
    });

    //Future<BuiltList<JsonObject>> reportsControllerGetDriverPerformanceReport({ String from, String to, String interval }) async
    test('test reportsControllerGetDriverPerformanceReport', () async {
      // TODO
    });

    //Future<JsonObject> reportsControllerGetRevenueReport({ String from, String to, String interval }) async
    test('test reportsControllerGetRevenueReport', () async {
      // TODO
    });

  });
}
