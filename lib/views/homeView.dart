import 'package:BUDdy/model/EnumSpeechBubbles.dart';
import 'package:BUDdy/views/DesignViews/sendMessageScreen.dart';
import 'package:flutter/material.dart';
import 'package:BUDdy/views/plantPageARView.dart';
import 'package:BUDdy/views/sessionCountdownView.dart';
import 'package:BUDdy/views/setupSessionView.dart';

import 'DesignViews/buttons.dart';

class HomeView extends StatelessWidget {
  final BubbleType? topSpeechBubble;
  final BubbleType? bottomSpeechBubble;

  const HomeView({super.key, this.topSpeechBubble, this.bottomSpeechBubble});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(children: [
          const SizedBox(width: 10, height: 104),
          Visibility(
              child: Center(
                  child: SizedBox(
                width: 200,
                height: 65,
                child: Text("Let’s start your study session!",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    textAlign: TextAlign.center),
              )),
              visible: topSpeechBubble == null),
          Visibility(
              child: SpeechBubble(true, BubbleType.topNewSession, context),
              visible: topSpeechBubble == BubbleType.topNewSession),
          Visibility(
              child: SpeechBubble(true, BubbleType.topSessionStart, context),
              visible: topSpeechBubble == BubbleType.topSessionStart),
          Visibility(
              child: SpeechBubble(true, BubbleType.topPlantGrew, context),
              visible: topSpeechBubble == BubbleType.topPlantGrew),
          const Spacer(),
          Container(
              margin: const EdgeInsets.only(top: 74.0),
              alignment: Alignment.center,
              child: Image.asset('assets/gifs/HomeExcitedBuddy.gif',
                  height: 280, width: 280)),
          const Spacer(),
          const SizedBox(height: 55, width: 50),
          Visibility(
              child: SimpleButton("Start session", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const SessionCountdownView())));
              }),
              visible: bottomSpeechBubble == null),
          Visibility(
              child:
                  SpeechBubble(true, BubbleType.bottomBuddyProgress, context),
              visible: bottomSpeechBubble == BubbleType.bottomBuddyProgress),
          Visibility(
              child: SpeechBubble(true, BubbleType.bottomSessionIcon, context),
              visible: bottomSpeechBubble == BubbleType.bottomSessionIcon),
          const Spacer(),
          const Spacer(),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 80.0,
              child: Container(
                  margin: EdgeInsets.only(top: 16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    shape: BoxShape.rectangle,
                    borderRadius: null,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(height: 10, width: 50),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.schedule, size: 24),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SetupSessionView()));
                                  }),
                              Text("Session",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          fontFamily: 'Roboto',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                  textAlign: TextAlign.center),
                              const Spacer()
                            ]),
                        const Spacer(),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.home, size: 24),
                                  onPressed: () {}),
                              Text("Home",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          fontFamily: 'Roboto',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                  textAlign: TextAlign.center),
                              const Spacer()
                            ]),
                        const Spacer(),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.eco, size: 24),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PlantPageARView()));
                                  }),
                              Text("Buddy",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          fontFamily: 'Roboto',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                  textAlign: TextAlign.center),
                              const Spacer(),
                            ]),
                        const SizedBox(height: 10, width: 50)
                      ],
                    ),
                  ))),
        ]));
  }
}
