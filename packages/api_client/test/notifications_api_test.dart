import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for NotificationsApi
void main() {
  final instance = ApiClient().getNotificationsApi();

  group(NotificationsApi, () {
    // Get my notifications
    //
    //Future notificationsControllerGetMyNotifications({ num page, num limit, String cursor }) async
    test('test notificationsControllerGetMyNotifications', () async {
      // TODO
    });

    // Get unread notification count
    //
    //Future notificationsControllerGetUnreadCount() async
    test('test notificationsControllerGetUnreadCount', () async {
      // TODO
    });

    // Mark all notifications as read
    //
    //Future notificationsControllerMarkAllAsRead() async
    test('test notificationsControllerMarkAllAsRead', () async {
      // TODO
    });

    // Mark a notification as read
    //
    //Future notificationsControllerMarkAsRead(String id) async
    test('test notificationsControllerMarkAsRead', () async {
      // TODO
    });

    // Send a notification manually
    //
    //Future notificationsControllerSendNotification(SendNotificationDto sendNotificationDto) async
    test('test notificationsControllerSendNotification', () async {
      // TODO
    });

  });
}
