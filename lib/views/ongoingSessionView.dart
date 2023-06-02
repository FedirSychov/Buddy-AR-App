import 'package:flutter/material.dart';
import 'dart:async';
import 'package:BUDdy/views/DesignViews/buttons.dart';
import 'package:BUDdy/views/selectActivityView.dart';
import 'package:BUDdy/views/sessionCompleteView.dart';
import 'package:BUDdy/views/setupSessionView.dart';

import '../clients/sharedPrefs.dart';
import '../viewModels/ongoingSessionViewModel.dart';

class OngoingSessionView extends StatelessWidget {
  final OngoingSessionViewModel viewModel = OngoingSessionViewModel();
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
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 65.0),
                    child: Header(cancelTimer: _cancelTimer)),
                Container(
                    margin: const EdgeInsets.only(top: 75.0),
                    child: const KeyVisual()),
                Container(
                  margin: const EdgeInsets.only(top: 65.0),
                  child: Countdown(
                      initTimer: _initTimer,
                      isFirstHalf: isFirstHalf,
                      viewModel: viewModel),
                )
              ],
            )));
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
                context, MaterialPageRoute(builder: (_) => SetupSessionView()));
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
        margin: const EdgeInsets.only(left: 15.0),
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
            margin: const EdgeInsets.only(right: 15.0),
            width: 32.0,
            height: 32.0,
            child: Image.asset('assets/images/icons/Cross.png',
                width: 24.0,
                height: 24.0,
                color: Theme.of(context).colorScheme.onBackground)),
      )
    ]);
  }
}

class KeyVisual extends StatelessWidget {
  const KeyVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/plants/learning.png',
        height: 233, width: 290);
  }
}

class Countdown extends StatefulWidget {
  final bool isFirstHalf;
  final Function initTimer;
  final OngoingSessionViewModel viewModel;

  const Countdown(
      {super.key,
      required this.initTimer,
      required this.isFirstHalf,
      required this.viewModel});

  @override
  State<Countdown> createState() => _CountdownState(viewModel: viewModel);
}

class _CountdownState extends State<Countdown> with WidgetsBindingObserver {
  final OngoingSessionViewModel viewModel;

  bool onGoing = false;
  bool hasBeenNotified = false;
  bool _isInForeground = true;

  late DateTime until = viewModel.getInitDateTimeUntil();
  late Duration timeLeft = viewModel.getInitRemainingDuration();
  late int breakPoint = viewModel.getBreakPoint();
  late Timer timer;

  _CountdownState({required this.viewModel});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
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

  void _showNotification() {
    if (_shouldNotifyAboutNearlyDone()) {
      viewModel.showBigTextNotification("Keep going!", "5 more minutes to go.");
      hasBeenNotified = true;
    }
    if (_shouldNotifyAboutStartingBreak()) {
      viewModel.showBigTextNotification("Let's take a pause!",
          "Hey! why don't you take a break?\nClick to start.");
    }
    if (_shouldNotifyAboutSessionComplete()) {
      viewModel.showBigTextNotification(
          "Hooray! Your session is complete.", "Let's check you plant buddy. ");
    }
  }

  bool _shouldNotifyAboutStartingBreak() {
    return widget.isFirstHalf && timeLeft.inSeconds <= breakPoint;
  }

  bool _shouldNotifyAboutNearlyDone() {
    bool shouldNotify = false;
    if (widget.isFirstHalf) {
      shouldNotify = timeLeft.inSeconds <= breakPoint + 300 && !hasBeenNotified;
    } else {
      shouldNotify = timeLeft.inSeconds <= 300 && !hasBeenNotified;
    }
    return shouldNotify;
  }

  bool _shouldNotifyAboutSessionComplete() {
    return !widget.isFirstHalf && timeLeft.inSeconds <= 0;
  }

  void countDown() {
    timeLeft = until.difference(DateTime.now());
    if (!_isInForeground) {
      _showNotification();
    }

    setState(() {
      if (timeLeft.inSeconds > 0) {
        if (widget.isFirstHalf && timeLeft.inSeconds <= breakPoint) {
          startActivityBreak();
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
                    margin: const EdgeInsets.only(top: 40.0),
                    width: 240,
                    height: 240,
                    child: Image.asset('assets/images/plants/closeBook.png')),
                Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    width: 294,
                    child: Text(
                        'You’re doing well. Let’s continue with the study session. You will get an activity break soon :D',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        textAlign: TextAlign.center)),
                Container(
                  margin: const EdgeInsets.only(top: 35.0),
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
    SharedPrefs().setSessionDuration(timeLeft.inSeconds);
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => SelectActivityView()));
  }

  @override
  Widget build(BuildContext context) {
    int hours = timeLeft.inHours % 24;
    int minutes = timeLeft.inMinutes % 60;
    int seconds = timeLeft.inSeconds % 60;
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
          margin: const EdgeInsets.only(top: 40.0),
          child: PauseButton("session", () {
            handleButtonPress();
          }, onGoing),
        )
      ],
    );
  }
}
