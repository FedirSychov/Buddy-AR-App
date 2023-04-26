import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../clients/notificationClient.dart';

class OngoingActivityViewModel {
  /* How to run Notifications:
    1. in View class define ViewModel
    2. run function viewModel.showBigTextNotification("name", "body");
  */

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
