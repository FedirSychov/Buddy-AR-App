import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../clients/notificationClient.dart';

class OngoingSessionViewModel {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  SetupSessionViewModel() {
    NotificationClient.initialize(flutterLocalNotificationsPlugin);
  }

  void showBigTextNotification(String title, String body) {
    NotificationClient.showBigTextNotification(
        title: title, body: body, fln: flutterLocalNotificationsPlugin);
  }
}
