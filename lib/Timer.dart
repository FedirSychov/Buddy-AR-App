import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/views/DesignViews/buttons.dart';

class Countdown extends StatelessWidget {
  bool onGoing = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          textDirection: TextDirection.ltr,
          children: [
            KeyVisual(timeType: TimeType.Learning),
            TimerSection(),
            // Testing of Buttons
            Container(height: 50),
            SimpleButton("testing", () {
              print("testing");
            }),
            Container(height: 50),
            CancelButton(() {})
          ],
        ));
  }
}

class TimerSection extends StatefulWidget {
  @override
  State<TimerSection> createState() => _TimerState();
}

class _TimerState extends State<TimerSection> {
  int hours = 2;
  int minutes = 30;
  int seconds = 20;
  bool onGoing = false;

  Timer? timer;

  void countDown() {
    setState(() {
      if (seconds > 0) {
        seconds--;
      } else if (minutes > 0) {
        minutes--;
        seconds = 59;
      } else if (hours > 0) {
        hours--;
        minutes = 59;
        seconds = 59;
      } else {
        onGoing = false;
        timer?.cancel();
      }
    });
  }

  void initTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countDown();
    });
    setState(() => onGoing = true);
  }

  void pauseCountdown() {
    setState(() => onGoing = false);
    timer?.cancel();
  }

  void resumeCountdown() {
    setState(() => onGoing = true);
  }

  void cancelCountdown() {
    timer?.cancel();
  }

  void handleButtonPress() {
    onGoing ? pauseCountdown() : initTimer();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (timer == null) {
      initTimer();
    }

    return Column(
      children: [
        Text(
          textDirection: TextDirection.ltr,
          '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 50),
        ),
        PauseButton("session", () {
          handleButtonPress();
        }, onGoing),
      ],
    );

    return Text(
      '$hours:$minutes:$seconds',
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 50),
    );
  }
}

class KeyVisual extends StatelessWidget {
  const KeyVisual({super.key, required this.timeType});

  final TimeType timeType;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 66.0),
        child: Image.asset(timeType.imagePath, height: 299, width: 233));
  }
}

enum TimeType {
  Learning('assets/images/learning.jpg'),
  Walking('walking.png');

  const TimeType(this.imagePath);
  final String imagePath;
}
