import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../clients/notificationClient.dart';
import '../clients/sharedPrefs.dart';
import '../views/selectActivityView.dart';
import '../views/sessionCompleteView.dart';

class OngoingSessionViewModel extends ChangeNotifier {
  final bool isFirstHalf;
  final BuildContext context;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool onGoing = false;
  bool hasBeenNotified = false;
  bool _isInForeground = true;
  int sessionDuration = SharedPrefs().getSessionDuration();

  late DateTime until = DateTime.now().add(Duration(seconds: sessionDuration));
  late Duration timeLeft = DateTime.now()
      .add(Duration(seconds: sessionDuration))
      .difference(DateTime.now());
  late int breakPoint =
      (Duration(seconds: sessionDuration).inSeconds / 2).floor();
  late Timer timer;

  OngoingSessionViewModel({required this.isFirstHalf, required this.context}) {
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
    if (!_isInForeground) {
      _showNotification();
    }
    if (timeLeft.inSeconds > 0) {
      if (isFirstHalf && timeLeft.inSeconds <= breakPoint) {
        startActivityBreak(context);
      }
    } else {
      cancelCountdown();
      SharedPrefs().incPlantProgress().then((hasGrown) => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        SessionCompleteView(plantHasGrown: hasGrown)))
          });
    }
    notifyListeners();
  }

  Timer _initTimer(Timer timer) {
    this.timer = timer;
    return timer;
  }

  void cancelTimer() {
    timer.cancel();
  }

  void _showNotification() {
    if (_shouldNotifyAboutNearlyDone()) {
      showBigTextNotification("Keep going!", "5 more minutes to go.");
      hasBeenNotified = true;
    }
    if (_shouldNotifyAboutStartingBreak()) {
      showBigTextNotification("Let's take a pause!",
          "Hey! why don't you take a break?\nClick to start.");
    }
    if (_shouldNotifyAboutSessionComplete()) {
      showBigTextNotification(
          "Hooray! Your session is complete.", "Let's check you plant buddy. ");
    }
  }

  bool _shouldNotifyAboutStartingBreak() {
    return isFirstHalf && timeLeft.inSeconds <= breakPoint;
  }

  bool _shouldNotifyAboutNearlyDone() {
    bool shouldNotify = false;
    if (isFirstHalf) {
      shouldNotify = timeLeft.inSeconds <= breakPoint + 300 && !hasBeenNotified;
    } else {
      shouldNotify = timeLeft.inSeconds <= 300 && !hasBeenNotified;
    }
    return shouldNotify;
  }

  bool _shouldNotifyAboutSessionComplete() {
    return !isFirstHalf && timeLeft.inSeconds <= 0;
  }

  void startActivityBreak(BuildContext context) {
    cancelCountdown();
    SharedPrefs().setSessionDuration(timeLeft.inSeconds);
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => SelectActivityView()));
  }

  void showBigTextNotification(String title, String body) {
    NotificationClient.showBigTextNotification(
        title: title, body: body, fln: flutterLocalNotificationsPlugin);
  }
}
