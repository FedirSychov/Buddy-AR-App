import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_app/views/DesignViews/buttons.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../clients/sharedPrefs.dart';
import '../model/activity.dart';
import 'activityCompleteView.dart';
import 'ongoingSessionView.dart';

class OngoingActivityView extends StatelessWidget {
  final Activity activity;
  Timer? timer;

  Timer _initTimer(Timer timer) {
    this.timer = timer;
    return timer;
  }

  void _cancelTimer() {
    timer?.cancel();
  }

  OngoingActivityView({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 65.0),
                child: Header(activity: activity, cancelTimer: _cancelTimer)),
            Container(
                margin: const EdgeInsets.only(top: 75.0),
                child: KeyVisual(activity: activity)),
            Container(
              margin: const EdgeInsets.only(top: 65.0),
              child: Countdown(initTimer: _initTimer, activity: activity),
            )
          ],
        ));
  }
}

class Header extends StatelessWidget {
  final Function cancelTimer;
  final Activity activity;

  const Header({super.key, required this.activity, required this.cancelTimer});

  Widget getAlertDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      title: Text('Discontinue activity?',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      content: Text(
          'Are you sure you want to discontinue with the chosen activity?',
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
                context,
                MaterialPageRoute(
                    builder: (_) => OngoingSessionView(isFirstHalf: false)));
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
      InkWell(
        onTap: () {
          _dialogBuilder(context);
        },
        child: Container(
            margin: const EdgeInsets.only(left: 15.0),
            width: 32.0,
            height: 32.0,
            child: Image.asset('assets/images/icons/Arrow.png',
                width: 24.0, height: 24.0)),
      ),
      Expanded(
          child: Text(activity.title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              textAlign: TextAlign.center)),
      Container(
        margin: const EdgeInsets.only(right: 15.0),
        width: 32.0,
        height: 32.0,
      ),
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
  final Function initTimer;
  final Activity activity;

  const Countdown({super.key, required this.initTimer, required this.activity});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  bool onGoing = false;
  int hours = SharedPrefs().getBreakHourDuration();
  int minutes = SharedPrefs().getBreakMinsDuration();
  int seconds = SharedPrefs().getBreakSecsDuration();
  late Timer timer;
  late DateTime until;
  late Duration timeLeft;

  @override
  void initState() {
    super.initState();
    until = DateTime.now()
        .add(Duration(hours: hours, minutes: minutes, seconds: seconds));
    startCountdown();
  }

  void countDown() {
    timeLeft = until.difference(DateTime.now());

    setState(() {
      if (timeLeft.inSeconds > 0) {
        hours = timeLeft.inHours % 24;
        minutes = timeLeft.inMinutes % 60;
        seconds = timeLeft.inSeconds % 60;
      } else {
        cancelCountdown();
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ActivityCompleteView()));
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
                    margin: const EdgeInsets.only(top: 30.0),
                    width: 294,
                    child: Text(widget.activity.title,
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.center)),
                Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    width: 328,
                    height: 200,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: VideoPlayer())),
                Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    width: 294,
                    child: Text(widget.activity.breakDescription,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center)),
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: PauseButton("session", () {
                    handleButtonPress();
                  }, onGoing),
                )
              ],
            ),
          );
        }).whenComplete(() => {if (!onGoing) resumeCountdown()});
  }

  void resumeCountdown() {
    until = DateTime.now().add(timeLeft);
    startCountdown();
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${hours > 0 ? '${hours.toString().padLeft(2, '0')}:' : ''}'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40.0),
          child: PauseButton("session", () {
            handleButtonPress();
          }, onGoing),
        )
      ],
    );
  }
}

class VideoPlayer extends StatelessWidget {
  final _controller = YoutubePlayerController.fromVideoId(
    videoId: 'dQw4w9WgXcQ',
    autoPlay: true,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  VideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}
