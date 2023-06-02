import 'package:flutter/material.dart';
import 'dart:async';
import 'package:BUDdy/views/DesignViews/buttons.dart';
import 'package:BUDdy/views/setupSessionView.dart';
import 'package:provider/provider.dart';
import '../viewModels/ongoingSessionViewModel.dart';

class OngoingSessionView extends StatelessWidget {
  final bool isFirstHalf;

  OngoingSessionView({super.key, required this.isFirstHalf});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => OngoingSessionViewModel(
                  isFirstHalf: isFirstHalf, context: context))
        ],
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 65.0),
                        child: Header()),
                    Container(
                        margin: const EdgeInsets.only(top: 75.0),
                        child: const KeyVisual()),
                    Container(
                      margin: const EdgeInsets.only(top: 65.0),
                      child: Countdown(),
                    )
                  ],
                ))));
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  Widget getAlertDialog(
      BuildContext context, OngoingSessionViewModel viewModel) {
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
            viewModel.cancelTimer();
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SetupSessionView()));
          },
        ),
      ],
    );
  }

  Future<void> _dialogBuilder(
      BuildContext context, OngoingSessionViewModel viewModel) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return getAlertDialog(context, viewModel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    OngoingSessionViewModel viewModel = context.read<OngoingSessionViewModel>();
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
          _dialogBuilder(context, viewModel);
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
  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    bool _isInForeground = state == AppLifecycleState.resumed;
    context.read<OngoingSessionViewModel>().setIsInForeground(_isInForeground);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void getPauseModal() {
    OngoingSessionViewModel viewModel = context.read<OngoingSessionViewModel>();
    showModalBottomSheet<void>(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
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
                        child: Image.asset('assets/images/closeBook.png')),
                    Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        width: 294,
                        child: Text(
                            'You’re doing well. Let’s continue with the study session. You will get an activity break soon :D',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                            textAlign: TextAlign.center)),
                    Container(
                      margin: const EdgeInsets.only(top: 35.0),
                      child: PauseButton("session", () {
                        handleButtonPress();
                      }, viewModel.isOnGoing),
                    )
                  ],
                ),
              );
            })
        .whenComplete(
            () => {if (!viewModel.isOnGoing) viewModel.resumeCountdown()});
  }

  void handleButtonPress() {
    OngoingSessionViewModel viewModel = context.read<OngoingSessionViewModel>();
    if (viewModel.isOnGoing) {
      viewModel.cancelCountdown();
      getPauseModal();
    } else {
      viewModel.resumeCountdown();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    OngoingSessionViewModel viewModel =
        context.watch<OngoingSessionViewModel>();

    Duration timeLeft = viewModel.getTimeLeft;
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
          }, viewModel.isOnGoing),
        )
      ],
    );
  }
}
