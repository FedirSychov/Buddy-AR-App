import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../clients/notificationClient.dart';
import '../clients/sharedPrefs.dart';
import '../views/activityCompleteView.dart';

class OngoingActivityViewModel extends ChangeNotifier {
  final BuildContext context;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool onGoing = false;
  bool hasBeenNotified = false;
  bool _isInForeground = true;
  int breakDuration = SharedPrefs().getBreakDuration();

  late DateTime until = DateTime.now().add(Duration(seconds: breakDuration));
  late Duration timeLeft = DateTime.now()
      .add(Duration(seconds: breakDuration))
      .difference(DateTime.now());
  late Timer timer;

  OngoingActivityViewModel({required this.context}) {
    NotificationClient.initialize(flutterLocalNotificationsPlugin);
    startCountdown(context);
  }

  bool get isOnGoing => onGoing;

  Duration get getTimeLeft => timeLeft;

  void setIsInForeground(bool isInForeground) {
    _isInForeground = isInForeground;
  }

  /// Starts the countdown to update the view every second
  /// Setting the Duration to exactly 1 second would update the view every >= 1 second
  /// The Duration chosen is therefor shorter
  void startCountdown(BuildContext context) {
    onGoing = true;
    timer =
        _initTimer(Timer.periodic(const Duration(milliseconds: 250), (timer) {
      countDown(context);
    }));
  }

  void resumeCountdown() {
    until = DateTime.now().add(timeLeft);
    startCountdown(context);
  }

  void cancelCountdown() {
    onGoing = false;
    timer.cancel();
  }

  void countDown(BuildContext context) {
    timeLeft = until.difference(DateTime.now());
    if (timeLeft.inSeconds <= 0) {
      cancelCountdown();
      if (!_isInForeground) {
        showBigTextNotification(
            "Hooray! Your break is complete.", "Let's get back to work! ");
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const ActivityCompleteView()));
    }
    ;
    notifyListeners();
  }

  Timer _initTimer(Timer timer) {
    this.timer = timer;
    return timer;
  }

  void cancelTimer() {
    timer.cancel();
  }

  void showBigTextNotification(String title, String body) {
    NotificationClient.showBigTextNotification(
        title: title, body: body, fln: flutterLocalNotificationsPlugin);
  }
}
