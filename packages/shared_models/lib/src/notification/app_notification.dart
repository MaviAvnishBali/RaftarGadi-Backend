import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

/// Category of a notification, used to pick an icon and routing target.
enum NotificationType { booking, payment, promo, system }

/// An in-app notification shown in the notifications feed.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String title,
    required String body,
    required NotificationType type,
    required DateTime createdAt,
    @Default(false) bool isRead,
    Map<String, dynamic>? data,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
