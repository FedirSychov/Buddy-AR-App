import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: Column(children: [
    //   // const Spacer(),
    //   Text("test text"),
    //   DefaultTabController(
    //       length: 3,
    //       child: TabBar(
    //           tabs: [Tab(text: "tab1"), Tab(text: "tab2"), Tab(text: "tab3")]))
    // ]));
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(tabs: [
            Tab(text: "tab1"),
            Tab(text: "tab2"),
            Tab(text: "tab3")
          ])),
        ));
  }
}
