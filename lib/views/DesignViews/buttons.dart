import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
      width: 131,
      child: TextButton(
        onPressed: () {
          widget.func();
        },
        child: Text(widget.text, style: TextStyle(fontSize: 14)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 133, 83, 0),
          foregroundColor: Colors.white,
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
            width: 157,
            child: TextButton.icon(
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
                  ? const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.pause_circle_outline, size: 18))
                  : const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.play_circle_outline, size: 18)),
              label: widget.onGoing
                  ? Text(
                      "Pause " + widget.text,
                      style: const TextStyle(fontSize: 13),
                    )
                  : Text("Resume " + widget.text,
                      style: const TextStyle(fontSize: 13)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 197, 241, 133),
                foregroundColor: Colors.black,
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )));
  }
}

class CancelButton extends StatefulWidget {
  Function func;

  CancelButton(this.func);

  @override
  State<CancelButton> createState() => _CancelButtonState();
}

class _CancelButtonState extends State<CancelButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 40,
      width: 131,
      child: TextButton(
        onPressed: () {
          widget.func();
        },
        child: Text("Cancel", style: TextStyle(fontSize: 13)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.black, width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(50)),
        ),
      ),
    ));
  }
}
