import 'package:flutter/material.dart';
import 'dart:async';
import 'package:BUDdy/views/DesignViews/buttons.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../model/activity.dart';
import '../viewModels/ongoingActivityViewModel.dart';
import 'ongoingSessionView.dart';

class OngoingActivityView extends StatelessWidget {
  final Activity activity;

  OngoingActivityView({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => OngoingActivityViewModel(context: context))
        ],
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
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
                      margin: const EdgeInsets.only(top: 65.0),
                      child: Countdown(activity: activity),
                    )
                  ],
                ))));
  }
}

class Header extends StatelessWidget {
  final Activity activity;

  const Header({super.key, required this.activity});

  Widget getAlertDialog(
      BuildContext context, OngoingActivityViewModel viewModel) {
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
            viewModel.cancelTimer();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => OngoingSessionView(isFirstHalf: false)));
          },
        ),
      ],
    );
  }

  Future<void> _dialogBuilder(
      BuildContext context, OngoingActivityViewModel viewModel) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return getAlertDialog(context, viewModel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    OngoingActivityViewModel viewModel =
        context.read<OngoingActivityViewModel>();
    return Row(children: [
      InkWell(
        onTap: () {
          _dialogBuilder(context, viewModel);
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
  final Activity activity;

  Countdown({required this.activity});

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
    context.read<OngoingActivityViewModel>().setIsInForeground(_isInForeground);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void getPauseModal(OngoingActivityViewModel viewModel) {
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
                        margin: const EdgeInsets.only(top: 30.0),
                        width: 294,
                        child: Text(widget.activity.title,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                            textAlign: TextAlign.center)),
                    Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        width: 328,
                        height: 200,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child:
                                VideoPlayer(videoId: widget.activity.videoId))),
                    Container(
                        margin: const EdgeInsets.only(top: 25.0),
                        width: 294,
                        child: Text(widget.activity.breakDescription,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                            textAlign: TextAlign.center)),
                    Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: PauseButton("activity", () {
                        handleButtonPress(viewModel);
                      }, viewModel.isOnGoing),
                    )
                  ],
                ),
              );
            })
        .whenComplete(
            () => {if (!viewModel.isOnGoing) viewModel.resumeCountdown()});
  }

  void handleButtonPress(OngoingActivityViewModel viewModel) {
    if (viewModel.isOnGoing) {
      viewModel.cancelCountdown();
      getPauseModal(viewModel);
    } else {
      viewModel.resumeCountdown();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    OngoingActivityViewModel viewModel =
        context.watch<OngoingActivityViewModel>();

    Duration timeLeft = viewModel.getTimeLeft;
    int hours = timeLeft.inHours % 24;
    int minutes = timeLeft.inMinutes % 60;
    int seconds = timeLeft.inSeconds % 60;

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
            handleButtonPress(viewModel);
          }, viewModel.isOnGoing),
        )
      ],
    );
  }
}

class VideoPlayer extends StatelessWidget {
  final String videoId;

  late final _controller = YoutubePlayerController.fromVideoId(
    videoId: videoId,
    autoPlay: true,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  VideoPlayer({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}
