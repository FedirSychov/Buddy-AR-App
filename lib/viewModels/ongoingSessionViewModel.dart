import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../clients/notificationClient.dart';
import '../clients/sharedPrefs.dart';

class OngoingSessionViewModel {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  int sessionDuration = SharedPrefs().getSessionDuration();

  SetupSessionViewModel() {
    NotificationClient.initialize(flutterLocalNotificationsPlugin);
  }

  void showBigTextNotification(String title, String body) {
    NotificationClient.showBigTextNotification(
        title: title, body: body, fln: flutterLocalNotificationsPlugin);
  }

  DateTime getInitDateTimeUntil() {
    return DateTime.now().add(Duration(seconds: sessionDuration));
  }

  Duration getInitRemainingDuration() {
    return DateTime.now().add(Duration(seconds: sessionDuration)).difference(DateTime.now());
  }

  int getBreakPoint() {
    return (Duration(seconds: sessionDuration).inSeconds / 2).floor();
  }
}
