import 'package:flutter/material.dart';

class SimpleButton extends StatefulWidget {
  String text;
  Function func;

  SimpleButton(this.text, this.func);

  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 40,
      child: TextButton(
        onPressed: () {
          widget.func();
        },
        child: Text(widget.text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontFamily: 'Roboto',
                color: Theme.of(context).colorScheme.onPrimary)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ));
  }
}

class PauseButton extends StatefulWidget {
  String text;
  Function func;
  bool onGoing;

  PauseButton(this.text, this.func, this.onGoing);

  @override
  State<PauseButton> createState() => _PauseButtonState();
}

class _PauseButtonState extends State<PauseButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () {
                widget.func();
                if (widget.onGoing) {
                  setState(() {
                    widget.onGoing = false;
                  });
                } else {
                  setState(() {
                    widget.onGoing = true;
                  });
                }
              },
              icon: widget.onGoing
                  ? Icon(Icons.pause_circle_outline, size: 18)
                  : Icon(Icons.play_circle_outline, size: 18),
              label: widget.onGoing
                  ? Text(
                      "Pause " + widget.text,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontFamily: 'Roboto',
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    )
                  : Text("Resume " + widget.text,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontFamily: 'Roboto',
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onSecondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )));
  }
}

class CancelButton extends StatefulWidget {
  String text;
  Function func;

  CancelButton(this.text, this.func);

  @override
  State<CancelButton> createState() => _CancelButtonState();
}

class _CancelButtonState extends State<CancelButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 40,
      child: TextButton(
        onPressed: () {
          widget.func();
        },
        child: Text(widget.text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontFamily: 'Roboto',
                color: Theme.of(context).colorScheme.outline)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.outline,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(50)),
        ),
      ),
    ));
  }
}
