import 'package:flutter/material.dart';
import 'package:my_app/clients/sharedPrefs.dart';
import 'package:my_app/main.dart';
import 'package:my_app/viewModels/setupSessionViewModel.dart';
import 'package:my_app/views/DesignViews/buttons.dart';
import 'package:my_app/views/homeView.dart';

class SetupSessionView extends StatelessWidget {
  var viewModel = SetupSessionViewModel();

  SetupSessionView({super.key});

  var sessionTimeArray = ["30 mins", "1 hour", "1,5 hours", "2 hours"];

  var breakTimeArray = ["15 mins", "30 mins", "45 mins", "1 hour"];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            width: 10,
            height: 64,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 62, vertical: 24),
            child: Center(
                child: Text(
              "Set-up a study session",
              style: TextStyle(fontFamily: 'Lato', fontSize: 24),
            )),
          ),
          const Center(
              child: SizedBox(
            width: 350,
            height: 48,
            child: Text(
              "Set-up a study session by choosing your preferable study and activity duration.",
              style: TextStyle(fontFamily: 'Lato', fontSize: 16),
              textAlign: TextAlign.center,
            ),
          )),
          const Spacer(),
          const Center(
            child: Text(
              "Set a duration for your study session",
              style: TextStyle(fontFamily: 'Lato', fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TimePicker(sessionTimeArray, 2, viewModel.basicStudyDuration,
                viewModel.saveCurrentStudyTime, viewModel.getCurrentStudyTime),
          ),
          const SizedBox(
            width: 10,
            height: 42,
          ),
          const Center(
            child: Text(
              "Set a duration for your study session",
              style: TextStyle(fontFamily: 'Lato', fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TimePicker(breakTimeArray, 2, viewModel.basicBreakDuration,
                viewModel.saveCurrentBreakTime, viewModel.getCurrentBreakTime),
          ),
          const SizedBox(
            width: 10,
            height: 52,
          ),
          const Center(
            child: Text(
              "You can change these settings anytime later",
              style: TextStyle(fontFamily: 'Lato', fontSize: 12),
            ),
          ),
          const Spacer(),
          SimpleButton("Save session", () {
            bool isOnboarded = SharedPrefs().getReturningUser() ?? false;
            if (isOnboarded) {
              // if user have passed onboarding, then setup session comes after home session and needs pop
              Navigator.pop(context);
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => HomeView())));
            }
          }),
          const Spacer(),
          const Spacer()
        ],
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  var timeArray = [];
  var position = 0;
  var basicTime = "";
  Function(String time) setTimeFuntion;
  Function getTimeFunction;

  TimePicker(this.timeArray, this.position, this.basicTime, this.setTimeFuntion,
      this.getTimeFunction) {
    for (var i = 0; i < timeArray.length; i++) {
      if (timeArray[i] == getTimeFunction()) {
        position = i;
      }
    }
  }

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(),
        color: const Color.fromARGB(255, 130, 117, 104),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: myBoxDecoration(),
      width: 300,
      height: 62,
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 248, 244),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    //call method from ViewModel
                    if (widget.position > 0) {
                      setState(() => widget.position--);
                      widget.setTimeFuntion(widget.timeArray[widget.position]);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(0, 0, 0, 0),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      padding: EdgeInsets.zero),
                  icon: const Icon(Icons.arrow_left, size: 28),
                  label: const Text(""),
                )),
            const Spacer(),
            Text(widget.timeArray[widget.position]),
            const Spacer(),
            Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (widget.position < widget.timeArray.length - 1) {
                          setState(() => widget.position++);
                          widget.setTimeFuntion(
                              widget.timeArray[widget.position]);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 140, 5, 5),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 10)),
                      icon: const Icon(Icons.arrow_left, size: 28),
                      label: const Text(""),
                    )))
          ],
        ),
      ),
    ));
  }
}
