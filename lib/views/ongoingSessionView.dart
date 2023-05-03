import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_app/views/DesignViews/buttons.dart';
import 'package:my_app/views/homeView.dart';
import 'package:my_app/views/selectActivityView.dart';
import 'package:my_app/views/sessionCompleteView.dart';

import '../clients/sharedPrefs.dart';

class OngoingSessionView extends StatelessWidget {
  final bool isFirstHalf;

  const OngoingSessionView({super.key, required this.isFirstHalf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 32.0),
                child: const Header()),
            Container(
                margin: const EdgeInsets.only(top: 73.0),
                child: const KeyVisual(timeType: TimeType.Learning)),
            Container(
              margin: const EdgeInsets.only(top: 66.0),
              child: Countdown(isFirstHalf: isFirstHalf),
            )
          ],
        ));
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        width: 32.0,
        height: 32.0,
      ),
      Expanded(
          child: Text("My Study session",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              textAlign: TextAlign.center)),
      InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const HomeView()));
        },
        child: Container(
            margin: const EdgeInsets.only(right: 16.0),
            width: 32.0,
            height: 32.0,
            child: Image.asset('assets/images/icons/Cross.png',
                width: 24.0, height: 24.0)),
      )
    ]);
  }
}

class KeyVisual extends StatelessWidget {
  const KeyVisual({super.key, required this.timeType});

  final TimeType timeType;

  @override
  Widget build(BuildContext context) {
    return Image.asset(timeType.assetPath, height: 233, width: 290);
  }
}

class Countdown extends StatefulWidget {
  final bool isFirstHalf;

  const Countdown({super.key, required this.isFirstHalf});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  DateTime until = DateTime.now().add(Duration(
      hours: SharedPrefs().getSessionHourDuration(),
      minutes: SharedPrefs().getSessionMinsDuration(),
      seconds: SharedPrefs().getSessionSecsDuration()));
  late Duration timeLeft;
  int breakPoint = (Duration(
                  hours: SharedPrefs().getSessionHourDuration(),
                  minutes: SharedPrefs().getSessionMinsDuration(),
                  seconds: SharedPrefs().getSessionSecsDuration())
              .inSeconds /
          2)
      .floor();

  int hours = SharedPrefs().getSessionHourDuration();
  int minutes = SharedPrefs().getSessionMinsDuration();
  int seconds = SharedPrefs().getSessionSecsDuration();

  bool onGoing = false;

  Timer? timer;

  void countDown() {
    timeLeft = until.difference(DateTime.now());

    setState(() {
      if (timeLeft.inSeconds > 0) {
        if (widget.isFirstHalf && timeLeft.inSeconds <= breakPoint) {
          cancelCountdown();
          SharedPrefs().setSessionMinsDuration(timeLeft.inHours);
          SharedPrefs().setSessionMinsDuration(timeLeft.inMinutes);
          SharedPrefs().setSessionSecsDuration(timeLeft.inSeconds);
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SelectActivityView()));
        } else {
          hours = timeLeft.inHours % 24;
          minutes = timeLeft.inMinutes % 60;
          seconds = timeLeft.inSeconds % 60;
        }
      } else {
        cancelCountdown();
        SharedPrefs().incPlantProgress();
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const SessionCompleteView()));
      }
    });
  }

  void pauseCountdown() {
    cancelCountdown();
    showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceTint,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: Column(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 42.0),
                    width: 240,
                    height: 240,
                    child: Image.asset('assets/images/closeBook.png')),
                Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    width: 294,
                    child: Text(
                        'You’re doing well. Let’s continue with the study session. You will get an activity break soon :D',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center)),
                Container(
                  margin: const EdgeInsets.only(top: 34.0),
                  child: PauseButton("session", () {
                    handleButtonPress();
                  }, onGoing),
                )
              ],
            ),
          );
        });
  }

  void resumeCountdown() {
    until = DateTime.now().add(timeLeft);
    startTimer();
    Navigator.pop(context);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countDown();
    });
    setState(() => onGoing = true);
  }

  void cancelCountdown() {
    onGoing = false;
    timer?.cancel();
  }

  void handleButtonPress() {
    onGoing ? pauseCountdown() : resumeCountdown();
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      startTimer();
    }

    return Column(
      children: [
        Text(
          '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        Container(
          margin: const EdgeInsets.only(top: 41.0),
          child: PauseButton("session", () {
            handleButtonPress();
          }, onGoing),
        )
      ],
    );
  }
}

enum TimeType {
  Learning('assets/images/learning.jpg'),
  Meditating('assets/gifs/Meditation.gif'),
  Stretching('assets/gifs/Stretch.gif'),
  Walking('assets/gifs/Walk.gif'),
  Yoga('assets/gifs/Yoga.gif');

  const TimeType(this.assetPath);

  final String assetPath;
}
