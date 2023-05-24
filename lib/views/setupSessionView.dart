import 'package:flutter/material.dart';
import 'package:BUDdy/viewModels/setupSessionViewModel.dart';
import 'package:BUDdy/views/DesignViews/buttons.dart';
import 'package:BUDdy/views/homeView.dart';

class SetupSessionView extends StatelessWidget {
  var viewModel = SetupSessionViewModel();

  SetupSessionView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(
            width: 10,
            height: 64,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 62, vertical: 24),
              child: Center(
                child: Text("Set-up a study session",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    textAlign: TextAlign.center),
              )),
          Center(
              child: SizedBox(
            width: 350,
            height: 48,
            child: Text(
              "Set-up a study session by choosing your preferable study and activity duration.",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              textAlign: TextAlign.center,
            ),
          )),
          const Spacer(),
          Center(
            child: Text(
              "Set a duration for your study session",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TimePicker(
                this.viewModel.sessionTimeArray,
                2,
                viewModel.basicStudyDuration,
                viewModel.saveCurrentStudyTime,
                viewModel.getCurrentStudyTime),
          ),
          const SizedBox(
            width: 10,
            height: 42,
          ),
          Center(
            child: Text(
              "Set a duration for your activity break",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TimePicker(
                this.viewModel.breakTimeArray,
                2,
                viewModel.basicBreakDuration,
                viewModel.saveCurrentBreakTime,
                viewModel.getCurrentBreakTime),
          ),
          const SizedBox(
            width: 10,
            height: 52,
          ),
          Center(
            child: Text(
              "You can change these settings anytime later",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          SimpleButton("Save session", () {
            viewModel.setCountdownValues();
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => HomeView())));
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
  Function(String time) setTimeFunction;
  Function getTimeFunction;

  TimePicker(this.timeArray, this.position, this.basicTime,
      this.setTimeFunction, this.getTimeFunction) {
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
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(color: Theme.of(context).colorScheme.outline),
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
                      widget.setTimeFunction(widget.timeArray[widget.position]);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      elevation: 0,
                      padding: EdgeInsets.zero),
                  icon: const Icon(Icons.arrow_left, size: 28),
                  label: const Text(""),
                )),
            const Spacer(),
            Text(widget.timeArray[widget.position],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface)),
            const Spacer(),
            Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (widget.position < widget.timeArray.length - 1) {
                          setState(() => widget.position++);
                          widget.setTimeFunction(
                              widget.timeArray[widget.position]);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSurface,
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
