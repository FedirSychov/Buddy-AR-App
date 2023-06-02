import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/activity.dart';
import '../viewModels/activityCountdownViewModel.dart';

class ActivityCountdownView extends StatelessWidget {
  final Activity activity;

  const ActivityCountdownView({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => ActivityCountdownViewModel(
                  context: context, activity: activity))
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
                        margin: const EdgeInsets.only(top: 40.0),
                        child: Text('Let\'s start?',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground))),
                    Container(
                      margin: const EdgeInsets.only(top: 60.0),
                      child: Countdown(),
                    )
                  ],
                ))));
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

class Countdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ActivityCountdownViewModel viewModel =
        context.watch<ActivityCountdownViewModel>();

    int seconds = viewModel.getSeconds;

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
