import 'package:flutter/material.dart';

import 'homeView.dart';

class SessionCompleteView extends StatelessWidget {
  const SessionCompleteView({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return ListView(
      children: const [Text("SessionCompleteView")],
    );
  }
}
=======
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 32.0),
                child: const Header()),
            Container(
                margin: const EdgeInsets.only(top: 80.0),
                child: const KeyVisual()),
            Container(
                margin: const EdgeInsets.only(top: 73.0),
                width: 300,
                child: Text(
                    'Hooray! You have successfully completed your study session.',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center))
          ],
        ));
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        width: 32.0,
        height: 32.0,
      ),
      Expanded(
          child: Text('Session Complete',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              textAlign: TextAlign.center)),
      InkWell(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeView()));
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
    return Image.asset('assets/gifs/Accomplishment.gif',
        height: 305, width: 284);
  }
}
>>>>>>> 66c31bf4fd7952ee31b52259cb493dfd0953d18c
