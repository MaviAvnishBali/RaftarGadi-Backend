import 'package:core/core.dart';
import 'package:shared_models/shared_models.dart';

/// Contract for the notifications feed.
abstract interface class NotificationRepository {
  Future<Result<PaginatedResponse<AppNotification>>> getNotifications({
    int page = 1,
    int pageSize = 20,
  });
}

/// [ApiClient]-backed implementation.
class ApiNotificationRepository implements NotificationRepository {
  ApiNotificationRepository(this._api);

  final ApiClient _api;

  @override
  Future<Result<PaginatedResponse<AppNotification>>> getNotifications({
    int page = 1,
    int pageSize = 20,
  }) => guardAsync(() async {
    final json = await _api.get(
      '/notifications',
      query: {
        'page': page,
        'pageSize': pageSize,
      },
    );
    return PaginatedResponse.fromJson(
      json,
      (item) => AppNotification.fromJson(item! as Map<String, dynamic>),
    );
  });
}
