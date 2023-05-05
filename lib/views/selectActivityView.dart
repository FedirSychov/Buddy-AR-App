import 'package:flutter/material.dart';
import 'package:my_app/viewModels/selectActivityViewModel.dart';

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
                  return GestureDetector(
                      onTap: () {},
                      child: ActivityView(
                        index: index,
                      ));
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
      )
    ]));
  }
}

class ActivityView extends StatelessWidget {
  final SelectActivityViewModel viewModel = SelectActivityViewModel();
  final index;
  ActivityView({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          color: Color.fromARGB(255, 246, 236, 228)),
      child: Center(
          child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            viewModel.activityList[index].title,
            style: TextStyle(fontFamily: 'Lato', fontSize: 24),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 43),
          width: 159,
          height: 161,
          child: Image.asset(viewModel.activityList[index].image),
        ),
        Container(
          width: 250,
          child: Text(
            viewModel.activityList[index].text,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Lato', fontSize: 14),
          ),
        ),
      ])),
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
      width: isActive ? 22.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.orange : Colors.grey,
          borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
