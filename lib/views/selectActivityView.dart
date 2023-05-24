import 'package:flutter/material.dart';
import 'package:BUDdy/viewModels/selectActivityViewModel.dart';
import 'package:BUDdy/views/activityCountdownView.dart';

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
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(children: [
              Container(
                  margin: const EdgeInsets.only(top: 64),
                  child: Center(
                      child: Text("Let’s take a pause!",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                          textAlign: TextAlign.center))),
              Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: SizedBox(
                    width: 300,
                    height: 48,
                    child: Text(
                        "Refresh, relax, and regain energy.\nSelect an activity that suits you best.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                        textAlign: TextAlign.center),
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
                          isActive:
                              widget._selectedIndex == index ? true : false))
                ],
              ),
            ])));
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
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.3),
                blurRadius: 2,
                offset: const Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).colorScheme.inverseSurface),
        child: Center(
            child: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Text(viewModel.activityList[index].title,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 43),
            width: 159,
            height: 161,
            child: Image.asset(viewModel.activityList[index].assetPath),
          ),
          Container(
              width: 250,
              child: Text(viewModel.activityList[index].text,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center)),
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
          color: isActive
              ? Theme.of(context).colorScheme.outlineVariant
              : Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
