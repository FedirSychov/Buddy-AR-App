import 'package:BUDdy/viewModels/onboardingViewModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../model/screens.dart';
import 'DesignViews/buttons.dart';
import 'choosePlantView.dart';

class OnboardingView extends StatefulWidget {
  OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final List<OnboardingScreen> items =
      Screens.values.map((e) => OnboardingScreen(screen: e)).toList();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: ListView(children: [
              Container(
                  margin: const EdgeInsets.only(top: 65.0),
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
                  )),
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
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ))
            ])));
  }
}

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key, required this.screen});

  final Screens screen;
  final viewModel = OnboardingViewModel();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          alignment: Alignment.center,
          child: Text(screen.title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              textAlign: TextAlign.center)),
      Container(
          margin: const EdgeInsets.only(top: 75.0),
          alignment: Alignment.center,
          child: Image.asset(screen.asset, height: 280, width: 280)),
      Container(
          margin: const EdgeInsets.only(top: 75.0),
          alignment: Alignment.center,
          child: Text(
            screen.description,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
          )),
      if (screen == Screens.stressRelieving)
        Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: SimpleButton('Let\'s start', () {
              viewModel.removePlantType();
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ChoosePlantView()));
            }))
    ]);
  }
}
