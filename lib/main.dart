import 'package:flutter/material.dart';
import 'package:my_app/Timer.dart';
import 'package:my_app/views/splashScreenView.dart';

import 'package:my_app/clients/sharedPrefs.dart';

final sharedPrefs = SharedPrefs();

Future<void> main() async {
  runApp(const SplashScreenView());
  await sharedPrefs.init();
  sharedPrefs.setIsReturningUser(true);
  print(sharedPrefs.getReturningUser());
  runApp(Start());
}

class Start extends StatelessWidget {
  const Start({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
      ),
      home: Countdown(),
    );
  }
}