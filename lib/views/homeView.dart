import 'package:BUDdy/model/EnumSpeechBubbles.dart';
import 'package:BUDdy/views/DesignViews/sendMessageScreen.dart';
import 'package:flutter/material.dart';
import 'package:BUDdy/views/plantPageARView.dart';
import 'package:BUDdy/views/sessionCountdownView.dart';
import 'package:BUDdy/views/setupSessionView.dart';
import 'package:BUDdy/views/ongoingSessionView.dart';

import 'DesignViews/buttons.dart';

class HomeView extends StatelessWidget {
  final BubbleType? topSpeechBubble;
  final BubbleType? bottomSpeechBubble;
  const HomeView({super.key, this.topSpeechBubble, this.bottomSpeechBubble});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const SizedBox(width: 10, height: 104),
      Visibility(
          child: const Center(
              child: SizedBox(
            width: 200,
            height: 65,
            child: Text(
              "Let’s start your study session!",
              style: TextStyle(fontFamily: 'Lato', fontSize: 24),
              textAlign: TextAlign.center,
            ),
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
          child: SpeechBubble(true, BubbleType.bottomBuddyProgress, context),
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
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 246, 236, 228),
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
                              icon: const Icon(Icons.access_time, size: 28),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SetupSessionView()));
                              }),
                          Text("Session",
                              style:
                                  TextStyle(fontFamily: 'Lato', fontSize: 12)),
                          const Spacer()
                        ]),
                    const Spacer(),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.home_outlined, size: 28),
                              onPressed: () {}),
                          Text("Home",
                              style:
                                  TextStyle(fontFamily: 'Lato', fontSize: 12)),
                          const Spacer()
                        ]),
                    const Spacer(),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.eco_outlined, size: 28),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlantPageARView()));
                              }),
                          const Text("Buddy",
                              style:
                                  TextStyle(fontFamily: 'Lato', fontSize: 12)),
                          const Spacer(),
                        ]),
                    const SizedBox(height: 10, width: 50)
                  ],
                ),
              ))),
    ]));
  }
}
