import 'package:flutter/material.dart';
import 'package:my_app/views/splashScreenView.dart';
import 'package:my_app/clients/sharedPrefs.dart';

import 'Timer.dart';

final sharedPrefs = SharedPrefs();

Future<void> main() async {
  runApp(const SplashScreenView());
  await sharedPrefs.init();
  sharedPrefs.setIsReturningUser(true);
  print(sharedPrefs.getReturningUser());
  runApp(Countdown());
}
