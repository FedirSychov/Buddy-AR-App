import 'package:flutter/material.dart';
import 'dart:async';
import '../model/activity.dart';
import 'ongoingActivityView.dart';

class ActivityCountdownView extends StatelessWidget {
  final Activity activity;

  const ActivityCountdownView({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 65.0),
                child: Header(activity: activity)),
            Container(
                margin: const EdgeInsets.only(top: 75.0),
                child: KeyVisual(activity: activity)),
            Container(
                margin: const EdgeInsets.only(top: 40.0),
                child: Text('Let\'s start?',
                    style: Theme.of(context).textTheme.displayLarge)),
            Container(
              margin: const EdgeInsets.only(top: 60.0),
              child: Countdown(activity: activity),
            )
          ],
        ));
  }
}

class Header extends StatelessWidget {
  final Activity activity;

  const Header({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Text(activity.title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              textAlign: TextAlign.center)),
    ]);
  }
}

class KeyVisual extends StatelessWidget {
  const KeyVisual({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Image.asset(activity.assetPath, height: 233, width: 290);
  }
}

class Countdown extends StatefulWidget {
  final Activity activity;

  const Countdown({super.key, required this.activity});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  bool onGoing = false;
  int seconds = 8;
  late Timer timer;
  late DateTime until;
  late Duration timeLeft;

  @override
  void initState() {
    super.initState();
    until = DateTime.now().add(Duration(seconds: seconds));
    startCountdown();
  }

  void countDown() {
    timeLeft = until.difference(DateTime.now());

    setState(() {
      if (timeLeft.inSeconds > 0) {
        seconds = timeLeft.inSeconds;
      } else {
        cancelCountdown();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    OngoingActivityView(activity: widget.activity)));
      }
    });
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countDown();
    });
    setState(() => onGoing = true);
  }

  void cancelCountdown() {
    onGoing = false;
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      RotatedBox(
        quarterTurns: -(seconds % 4),
        child: Image.asset('assets/images/loadingCircle.png',
            width: 108, height: 108),
      ),
      Text(seconds.toString().padLeft(2, '0'),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary, fontSize: 45.0),
          textAlign: TextAlign.center),
    ]);
  }
}
