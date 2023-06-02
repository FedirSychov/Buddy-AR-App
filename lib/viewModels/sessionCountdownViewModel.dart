import 'dart:async';

import 'package:flutter/material.dart';
import '../model/activity.dart';
import '../views/ongoingActivityView.dart';
import '../views/ongoingSessionView.dart';

class SessionCountdownViewModel extends ChangeNotifier {
  final BuildContext context;

  SessionCountdownViewModel({required this.context}) {
    startCountdown(context);
  }

  bool onGoing = false;
  int seconds = 8;
  late Timer timer;
  late DateTime until = DateTime.now().add(Duration(seconds: seconds));
  late Duration timeLeft;

  int get getSeconds => seconds;

  void countDown(BuildContext context) {
    timeLeft = until.difference(DateTime.now());

      if (timeLeft.inSeconds > 0) {
        seconds = timeLeft.inSeconds;
      } else {
        cancelCountdown();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => OngoingSessionView(isFirstHalf: true)));
      };
    notifyListeners();
  }

  void startCountdown(BuildContext context) {
    onGoing = true;
    timer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      countDown(context);
    });
  }

  void cancelCountdown() {
    onGoing = false;
    timer.cancel();
  }
}