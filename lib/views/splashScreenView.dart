import 'package:flutter/material.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SplashScreenView',
      theme: ThemeData(
        fontFamily: 'Lato',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.w400, height: 32.0),
          bodyLarge: TextStyle(
              fontSize: 57.0, fontWeight: FontWeight.w400, height: 64.0),
          bodyMedium: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w400, height: 24.0),
          bodySmall: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.w400, height: 20.0),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff855300),
          onPrimary: const Color(0xffFFFFFF),
          primaryContainer: const Color(0xffFFDDB8),
          onPrimaryContainer: const Color(0xff2A1700),
          secondary: const Color(0xff456808),
          onSecondary: const Color(0xffFFFFFF),
          secondaryContainer: const Color(0xffC5F185),
          onSecondaryContainer: const Color(0xff111F00),
          tertiary: const Color(0xff54643D),
          onTertiary: const Color(0xffFFFFFF),
          tertiaryContainer: const Color(0xffD7E9B8),
          onTertiaryContainer: const Color(0xff131F02),
          error: const Color(0xffBA1A1A),
          onError: const Color(0xffFFFFFF),
          errorContainer: const Color(0xffFFDAD6),
          onErrorContainer: const Color(0xff410002),
          background: const Color(0xffFFFBFF),
          onBackground: const Color(0xff1F1B16),
          surface: const Color(0xffFFFBFF),
          onSurface: const Color(0xff1F1B16),
          surfaceVariant: const Color(0xffF1E0D0),
          onSurfaceVariant: const Color(0xff504539),
          outline: const Color(0xff827568),
        ),
      ),
      home: MyHomePage(
        title: 'Test',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return FittedBox(
        fit: BoxFit.fill, child: Image.asset('assets/gifs/SplashIntro.gif'));
  }
}
