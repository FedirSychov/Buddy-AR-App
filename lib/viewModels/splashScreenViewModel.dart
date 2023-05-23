import 'package:flutter/material.dart';
import 'package:BUDdy/clients/sharedPrefs.dart';
import 'package:BUDdy/views/onboardingView.dart';
import 'package:BUDdy/views/setupSessionView.dart';

class SplashScreenViewModel {
  Widget getNextView() {
    bool isReturningUser = SharedPrefs().getReturningUser();
    return isReturningUser ? SetupSessionView() : OnboardingView();
  }
}
