import 'dart:async';

import 'package:BUDdy/viewModels/splashScreenViewModel.dart';
import 'package:flutter/material.dart';
import 'package:BUDdy/clients/sharedPrefs.dart';
import 'package:BUDdy/views/onboardingView.dart';
import 'package:BUDdy/views/setupSessionView.dart';

class SplashScreenView extends StatelessWidget {
  SplashScreenView({super.key});

  final viewModel = SplashScreenViewModel();

  void startTimer(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => this.viewModel.getNextView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return FittedBox(
        fit: BoxFit.fill, child: Image.asset('assets/gifs/SplashIntro.gif'));
  }
}
