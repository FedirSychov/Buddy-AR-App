import 'package:flutter/material.dart';
import 'package:my_app/Timer.dart';
import 'package:my_app/views/splashScreenView.dart';

import 'SharedPrefs.dart';

final sharedPrefs = SharedPrefs();

Future<void> main() async {
  runApp(const SplashScreenView());
  await sharedPrefs.init();
  runApp(Countdown());
}