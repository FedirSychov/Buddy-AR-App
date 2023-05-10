import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_app/views/DesignViews/buttons.dart';
import 'package:my_app/views/homeView.dart';
import 'package:my_app/views/selectActivityView.dart';
import 'package:my_app/views/sessionCompleteView.dart';

import '../clients/sharedPrefs.dart';

class OngoingSessionView extends StatelessWidget {
  final bool isFirstHalf;
  Timer? timer;

  Timer _initTimer(Timer timer) {
    this.timer = timer;
    return timer;
  }

  void _cancelTimer() {
    timer?.cancel();
  }

  OngoingSessionView({super.key, required this.isFirstHalf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 32.0),
                child: Header(cancelTimer: _cancelTimer)),
            Container(
                margin: const EdgeInsets.only(top: 73.0),
                child: const KeyVisual()),
            Container(
              margin: const EdgeInsets.only(top: 66.0),
              child: Countdown(initTimer: _initTimer, isFirstHalf: isFirstHalf),
            )
          ],
        ));
  }
}

class Header extends StatelessWidget {
  final Function cancelTimer;

  const Header({super.key, required this.cancelTimer});

  Widget getAlertDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      title: Text('Abort study session?',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      content: Text(
          'This will reset any progress that you have made. Keep going! You’re almost there.',
          style:
              TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Accept'),
          onPressed: () {
            cancelTimer();
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HomeView()));
          },
        ),
      ],
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return getAlertDialog(context);
      },
    );
  }

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
          _dialogBuilder(context);
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
  const KeyVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/learning.jpg', height: 233, width: 290);
  }
}

class Countdown extends StatefulWidget {
  final bool isFirstHalf;
  final Function initTimer;

  const Countdown(
      {super.key, required this.initTimer, required this.isFirstHalf});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  bool onGoing = false;
  int hours = SharedPrefs().getSessionHourDuration();
  int minutes = SharedPrefs().getSessionMinsDuration();
  int seconds = SharedPrefs().getSessionSecsDuration();
  late Timer timer;
  late DateTime until;
  late Duration timeLeft;
  late int breakPoint;

  @override
  void initState() {
    super.initState();
    until = DateTime.now()
        .add(Duration(hours: hours, minutes: minutes, seconds: seconds));
    breakPoint =
        (Duration(hours: hours, minutes: minutes, seconds: seconds).inSeconds /
                2)
            .floor();
    startCountdown();
  }

  void countDown() {
    timeLeft = until.difference(DateTime.now());

    setState(() {
      if (timeLeft.inSeconds > 0) {
        hours = timeLeft.inHours % 24;
        minutes = timeLeft.inMinutes % 60;
        seconds = timeLeft.inSeconds % 60;
        if (widget.isFirstHalf && timeLeft.inSeconds <= breakPoint) {
          startActivityBreak();
        }
      } else {
        cancelCountdown();
        SharedPrefs().incPlantProgress();
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const SessionCompleteView()));
      }
    });
  }

  void startCountdown() {
    timer =
        widget.initTimer(Timer.periodic(const Duration(seconds: 1), (timer) {
      countDown();
    }));
    setState(() => onGoing = true);
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
        }).whenComplete(() => { if (!onGoing) resumeCountdown() });
  }

  void resumeCountdown() {
    until = DateTime.now().add(timeLeft);
    startCountdown();
    //Navigator.pop(context);
  }

  void cancelCountdown() {
    onGoing = false;
    timer.cancel();
  }

  void handleButtonPress() {
    if (onGoing) {
      pauseCountdown();
    } else {
      resumeCountdown();
      Navigator.pop(context);
    }
  }

  void startActivityBreak() {
    cancelCountdown();
    SharedPrefs().setSessionHoursDuration(hours);
    SharedPrefs().setSessionMinsDuration(minutes);
    SharedPrefs().setSessionSecsDuration(seconds);
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => SelectActivityView()));
  }

  @override
  Widget build(BuildContext context) {
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
