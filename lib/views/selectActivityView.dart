import 'package:flutter/material.dart';
import 'package:BUDdy/viewModels/selectActivityViewModel.dart';
import 'package:BUDdy/views/activityCountdownView.dart';
import 'package:BUDdy/views/ongoingActivityView.dart';

class SelectActivityView extends StatefulWidget {
  var viewModel = SelectActivityViewModel();
  var _selectedIndex = 0;

  SelectActivityView({super.key});

  @override
  State<SelectActivityView> createState() => _SelectActivityViewState();
}

class _SelectActivityViewState extends State<SelectActivityView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
          margin: const EdgeInsets.only(top: 64),
          child: const Center(
              child: Text(
            "Let’s take a pause!",
            style: TextStyle(fontFamily: 'Lato', fontSize: 24),
          ))),
      Container(
          margin: const EdgeInsets.only(top: 24),
          child: const SizedBox(
            width: 300,
            height: 48,
            child: Text(
              "Refresh, relax, and regain energy. Select an activity that suits you best.",
              style: TextStyle(fontFamily: 'Lato', fontSize: 16),
              textAlign: TextAlign.center,
            ),
          )),
      Center(
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 60.0),
            height: 400,
            // width: 200,
            child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    widget._selectedIndex = index;
                  });
                },
                controller: PageController(viewportFraction: 1),
                itemCount: widget.viewModel.activityList.length,
                itemBuilder: (context, index) {
                  return ActivityView(
                    index: index,
                  );
                })),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
              widget.viewModel.activityList.length,
              (index) => Indicator(
                  isActive: widget._selectedIndex == index ? true : false))
        ],
      ),
    ]));
  }
}

class ActivityView extends StatelessWidget {
  final SelectActivityViewModel viewModel = SelectActivityViewModel();
  final index;
  ActivityView({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: ((MediaQuery.of(context).size.width - 280) / 2.0),
            vertical: 20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              )
            ],
            borderRadius: BorderRadius.circular(20.0),
            color: const Color.fromARGB(255, 246, 236, 228)),
        child: Center(
            child: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              viewModel.activityList[index].title,
              style: const TextStyle(fontFamily: 'Lato', fontSize: 24),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 43),
            width: 159,
            height: 161,
            child: Image.asset(viewModel.activityList[index].assetPath),
          ),
          Container(
            width: 250,
            child: Text(
              viewModel.activityList[index].text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Lato', fontSize: 14),
            ),
          ),
        ])),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ActivityCountdownView(
                    activity: viewModel.activityList[index])));
      },
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 15.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
          color:
              isActive ? const Color.fromARGB(255, 255, 176, 57) : Colors.grey,
          borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
