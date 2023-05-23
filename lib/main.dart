import 'package:flutter/material.dart';
import 'package:BUDdy/views/splashScreenView.dart';
import 'package:BUDdy/clients/sharedPrefs.dart';
import 'package:flutter/services.dart';

final sharedPrefs = SharedPrefs();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  await sharedPrefs.init();
  runApp(const BUDdyApp());
}

class BUDdyApp extends StatelessWidget {
  const BUDdyApp({super.key, bool? isReturningUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BUDdy App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Lato',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w400,
              color: Color(
                  0xffff0000)), // to see missing use of context colorScheme
          bodyLarge: TextStyle(
              fontSize: 57.0,
              fontWeight: FontWeight.w400,
              color: Color(0xffff0000)),
          bodyMedium: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Color(0xffff0000)),
          bodySmall: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color(0xffff0000)),
          labelLarge: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Color(0xffff0000)),
          labelMedium: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Color(0xffff0000)),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xff855300),
            onPrimary: const Color(0xffFFFFFF),
            primaryContainer: const Color(0xffFFDDB8),
            onPrimaryContainer: const Color(0xff2A1700),
            inversePrimary: const Color(0xffFFB960),
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
            surface: const Color(0xffFFF8F4),
            onSurface: const Color(0xff1F1B16),
            surfaceVariant: const Color(0xffF1E0D0),
            onSurfaceVariant: const Color(0xff504539),
            inverseSurface: const Color(
                0xffF6ECE4), // surfaceContainer (not supported anymore) in design
            surfaceTint: const Color(0xffFCF2EA),
            outline: const Color(0xff827568),
            outlineVariant: const Color(0xffD4C4B5)),
      ),
      home: SplashScreenView(),
    );
  }
}
