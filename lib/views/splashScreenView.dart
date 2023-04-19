import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/views/onboardingView.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  void startTimer(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => OnboardingView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return FittedBox(
      fit: BoxFit.fill,
      child: Image.asset(
          'images/splashScreen.png'
      )
    );
  }
}
