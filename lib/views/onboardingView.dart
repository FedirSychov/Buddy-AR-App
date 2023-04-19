import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final items = [
    Image.asset('images/learning.png'),
    Image.asset('images/splashScreen.png')
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: items,
            ),
            DotsIndicator(
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
          ],
        ),
      ),
    );
  }
}

