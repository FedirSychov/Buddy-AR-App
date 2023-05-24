import 'package:flutter/material.dart';
import 'dart:async';
import 'package:BUDdy/views/DesignViews/buttons.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../clients/sharedPrefs.dart';
import '../model/activity.dart';
import '../viewModels/ongoingActivityViewModel.dart';
import 'activityCompleteView.dart';
import 'ongoingSessionView.dart';

class OngoingActivityView extends StatelessWidget {
  final OngoingActivityViewModel viewModel = OngoingActivityViewModel();
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
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 65.0),
                    child:
                        Header(activity: activity, cancelTimer: _cancelTimer)),
                Container(
                    margin: const EdgeInsets.only(top: 75.0),
                    child: KeyVisual(activity: activity)),
                Container(
                  margin: const EdgeInsets.only(top: 65.0),
                  child: Countdown(
                      initTimer: _initTimer,
                      activity: activity,
                      viewModel: viewModel),
                )
              ],
            )));
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
            textStyle: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
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
                width: 24.0,
                height: 24.0,
                color: Theme.of(context).colorScheme.onBackground)),
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
  final OngoingActivityViewModel viewModel;

  const Countdown(
      {super.key,
      required this.initTimer,
      required this.activity,
      required this.viewModel});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> with WidgetsBindingObserver {
  bool onGoing = false;
  bool _isInForeground = true;
  int hours = SharedPrefs().getBreakHourDuration();
  int minutes = SharedPrefs().getBreakMinsDuration();
  int seconds = SharedPrefs().getBreakSecsDuration();
  late Timer timer;
  late DateTime until;
  late Duration timeLeft;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    until = DateTime.now()
        .add(Duration(hours: hours, minutes: minutes, seconds: seconds));
    startCountdown();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
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
        if (!_isInForeground) {
          widget.viewModel.showBigTextNotification(
              "Hooray! Your break is complete.", "Let's get back to work! ");
        }
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ActivityCompleteView()));
      }
    });
  }

  /// Starts the countdown to update the view every second
  /// Setting the Duration to exactly 1 second would update the view every >= 1 second
  /// The Duration chosen is therefor shorter
  void startCountdown() {
    timer = widget
        .initTimer(Timer.periodic(const Duration(milliseconds: 250), (timer) {
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
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
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
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        textAlign: TextAlign.center)),
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: PauseButton("activity", () {
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
          child: PauseButton("activity", () {
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
