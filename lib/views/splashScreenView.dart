import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/clients/sharedPrefs.dart';
import 'package:my_app/views/onboardingView.dart';
import 'package:my_app/views/setupSessionView.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  Widget getNextView() {
    bool? isReturningUser = SharedPrefs().getReturningUser();
    if (isReturningUser == null) {
      return const OnboardingView();
    }
    return isReturningUser ? SetupSessionView() : const OnboardingView();
  }

  void startTimer(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => getNextView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return FittedBox(
        fit: BoxFit.fill, child: Image.asset('assets/gifs/SplashIntro.gif'));
  }
}
