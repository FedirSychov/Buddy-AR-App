import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../clients/notificationClient.dart';
import '../clients/sharedPrefs.dart';

class OngoingActivityViewModel {
  int breakDuration = SharedPrefs().getBreakDuration();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  SetupSessionViewModel() {
    NotificationClient.initialize(flutterLocalNotificationsPlugin);
  }

  void showBigTextNotification(String title, String body) {
    NotificationClient.showBigTextNotification(
        title: title, body: body, fln: flutterLocalNotificationsPlugin);
  }

  DateTime getInitDateTimeUntil() {
    return DateTime.now().add(Duration(seconds: breakDuration));
  }

  Duration getInitRemainingDuration() {
    return DateTime.now()
        .add(Duration(seconds: breakDuration))
        .difference(DateTime.now());
  }
}
