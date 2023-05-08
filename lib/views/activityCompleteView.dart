import 'package:flutter/material.dart';
import 'package:my_app/views/DesignViews/buttons.dart';
import 'ongoingSessionView.dart';

class ActivityCompleteView extends StatelessWidget {
  const ActivityCompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 32.0),
                child: const Header()),
            Container(
                margin: const EdgeInsets.only(top: 107.0),
                child: const KeyVisual()),
            Container(
                margin: const EdgeInsets.only(top: 100.0),
                child: SimpleButton('Continue', () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              OngoingSessionView(isFirstHalf: false)));
                }))
          ],
        ));
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 290,
        child: Text('Looks like your break is up! Let\'s get back to work.',
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
            textAlign: TextAlign.center));
  }
}

class KeyVisual extends StatelessWidget {
  const KeyVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/closeBook.png', height: 316, width: 294);
  }
}
