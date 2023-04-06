import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Countdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        KeyVisual(timeType: TimeType.Learning),
        TimerSection()
      ],
    );
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
    timer = Timer.periodic(const Duration(seconds: 1),
            (timer) {
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
        Text('${hours.toString().padLeft(2, '0')}:'
            '${minutes.toString().padLeft(2, '0')}:'
            '${seconds.toString().padLeft(2, '0')}',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 50),),
        ElevatedButton.icon(
          onPressed: () {
            handleButtonPress();
          },
          icon: onGoing ? Icon(Icons.add, size:18) : Icon(Icons.read_more, size: 18),
          label: onGoing ? Text("OnGoing") : Text("Paused")
        )
      ],
    );


    return Text('$hours:$minutes:$seconds',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 50),);
  }
}

class KeyVisual extends StatelessWidget {
  const KeyVisual({
    super.key,
    required this.timeType
  });

  final TimeType timeType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 66.0),
      child: Image.asset(
        timeType.imagePath,
        height: 299,
        width: 233
      )
    );
  }


}

enum TimeType {
  Learning('images/learning.jpg'),
  Walking('walking.png');

  const TimeType(this.imagePath);
  final String imagePath;
}

