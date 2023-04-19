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
          displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, height: 32.0),
          bodyLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.w400, height: 64.0),
          bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, height: 24.0),
          bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, height: 20.0),
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
      home: MyHomePage(title: 'Test',),
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
<<<<<<< Updated upstream
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button thdddis many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
=======
    startTimer(context);
    return FittedBox(
        fit: BoxFit.fill, child: Image.asset('assets/gifs/SplashIntro.gif'));
>>>>>>> Stashed changes
  }
}
