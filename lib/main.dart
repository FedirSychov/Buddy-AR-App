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
      themeMode: ThemeMode.system,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: SplashScreenView(),
    );
  }
}

class Themes {
  static bool useMaterial3 = true;
  static String fontFamily = 'Lato';
  static TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
  );
  static ThemeData lightTheme = ThemeData(
    useMaterial3: useMaterial3,
    fontFamily: fontFamily,
    textTheme: textTheme,
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
      inverseSurface: const Color(0xffF6ECE4),
      // surfaceContainer (not supported anymore) in design
      onInverseSurface: const Color(0xff855300),
      // primaryFixed in design (value not supported by Flutter anymore)
      surfaceTint: const Color(0xffFCF2EA),
      outline: const Color(0xff827568),
      outlineVariant: const Color(0xffD4C4B5),
      shadow: const Color(0xff000000),
    ),
  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: useMaterial3,
      fontFamily: fontFamily,
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xffFFB960),
        onPrimary: const Color(0xff472A00),
        primaryContainer: const Color(0xff653E00),
        onPrimaryContainer: const Color(0xffFFDDB8),
        inversePrimary: const Color(0xff855300),
        secondary: const Color(0xffAAD46C),
        onSecondary: const Color(0xff213600),
        secondaryContainer: const Color(0xff324F00),
        onSecondaryContainer: const Color(0xffC5F185),
        tertiary: const Color(0xffBBCD9E),
        onTertiary: const Color(0xff273513),
        tertiaryContainer: const Color(0xff3D4B27),
        onTertiaryContainer: const Color(0xffD7E9B8),
        error: const Color(0xffFFB4AB),
        onError: const Color(0xff690005),
        errorContainer: const Color(0xff93000A),
        onErrorContainer: const Color(0xffFFDAD6),
        background: const Color(0xff1F1B16),
        onBackground: const Color(0xffEBE1D9),
        surface: const Color(0xff17130E),
        onSurface: const Color(0xffEBE1D9),
        surfaceVariant: const Color(0xff504539),
        onSurfaceVariant: const Color(0xffD4C4B5),
        inverseSurface: const Color(0xff231F1A),
        // surfaceContainer in design (value not supported by Flutter anymore)
        onInverseSurface: const Color(0xffFFDDB8),
        // primaryFixed in design (value not supported by Flutter anymore)
        surfaceTint: const Color(0xff1F1B16),
        // ??
        outline: const Color(0xff9C8E80),
        outlineVariant: const Color(0xff9C8E80),
        shadow: const Color(0xff000000),
      ));
}
