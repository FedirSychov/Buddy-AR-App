import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_app/views/setupSessionView.dart';

import '../clients/sharedPrefs.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final List<OnboardingScreen> items = Screens.values.map((e) => OnboardingScreen(screen: e)).toList();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: CarouselSlider(
            options: CarouselOptions(
              height: 653,
              autoPlay: false,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: items,
          )
        ),
        Container(
          height: 30,
          margin: const EdgeInsets.only(top: 40.0, bottom: 45.0),
          child: DotsIndicator(
            dotsCount: items.length,
            position: currentIndex.toDouble(),
            decorator: DotsDecorator(
            color: Theme.of(context).colorScheme.surfaceVariant,
            activeColor: Theme.of(context).colorScheme.outlineVariant,
            size: const Size.square(10.0),
            activeSize: const Size(18.0, 10.0),
            spacing: const EdgeInsets.all(4.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          )
        )
      ]
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, required this.screen});

  final Screens screen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 32.0),
            alignment: Alignment.center,
            child: Text(screen.title,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center
            )
        ),
        Container(
          margin: const EdgeInsets.only(top: 74.0),
          alignment: Alignment.center,
          child: Image.asset(screen.asset,
              height: 280,
              width: 280
          )
        ),
        Container(
            margin: const EdgeInsets.only(top: 73.0),
            alignment: Alignment.center,
            child: Text(screen.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            )
        ),
        if (screen == Screens.stressRelieving)
          Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: SimpleButton('Let\'s start',
              () {
                SharedPrefs().setIsReturningUser(true);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SetupSessionView()));
              }
            )
          )
      ]
    );
  }
}

enum Screens {
  healthyStudying('assets/gifs/OnboardingWelcomeBuddy.gif',
      'Healthy Study Routine',
      'Hello! I am your Buddy. I will help you create a healthy study routine by reminding you to take mini pauses during your study sessions.'
  ),
  nourish('assets/images/nourish.png',
    'Nourishing',
    'Your Buddy is connected to an AR plant that grows as you take pauses during your study sessions. Excited? Let’s set your AR plant!'
  ),
  stressRelieving('assets/gifs/BoardingPlantGrow.gif',
      'Stress Relieving',
      'Choose a relaxing stress relieving activity to perform during the pause which will refresh your mind and help you regain your focus.'
  );

  const Screens(this.asset, this.title, this.description);
  final String asset;
  final String title;
  final String description;
}



// This here only until Button-Branch has been merged

class SimpleButton extends StatefulWidget {
  String text;
  Function func;

  SimpleButton(this.text, this.func);

  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          height: 40,
          width: 131,
          child: TextButton(
            onPressed: () {
              widget.func();
            },
            child: Text(widget.text,
                style: TextStyle(fontSize: 13), textDirection: TextDirection.ltr),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 133, 83, 0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ));
  }
}

