import 'package:flutter/material.dart';

class SessionCompleteView extends StatelessWidget {
  const SessionCompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 32.0), child: const Header()),
            Container(
                margin: const EdgeInsets.only(top: 80.0), child: const KeyVisual()),
            Container(
                margin: const EdgeInsets.only(top: 73.0),
                child: Text('Hooray! You have successfully completed your study session.',
    style: Theme.of(context).textTheme.displayLarge))
          ],
        ));
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Text('Looks like your break is up! Let\'s get back to work.',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              textAlign: TextAlign.center)),
    ]);
  }
}

class KeyVisual extends StatelessWidget {
  const KeyVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/gifs/Accomplishment.gif', height: 305, width: 284);
  }
}
