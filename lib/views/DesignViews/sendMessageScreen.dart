import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_app/views/DesignViews/customShape.dart';

class SpeechBubble extends StatefulWidget {
  String message;
  bool smallText;
  bool leftSide;
  var context;
  late double width;
  SpeechBubble(this.message, this.smallText, this.leftSide, this.context) {
    width = MediaQuery.of(context).size.height;
  }

  @override
  State<SpeechBubble> createState() => _SpeechBubble();
}

class _SpeechBubble extends State<SpeechBubble> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    repeatOnce();
  }

  // play animation
  void repeatOnce() async {
    await controller.forward();
  }

  //play reversed animation
  void reverseOnce() async {
    await controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding:
            const EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // SizedBox(height: 30),
            Flexible(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 246, 236, 228),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                          topRight: Radius.circular(18)),
                    ),
                    child: Text(
                      widget.message,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: widget.smallText ? 14 : 24),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50, right: 20),
                  child: CustomPaint(
                      painter: CustomShape(
                          const Color.fromARGB(255, 246, 236, 228),
                          widget.leftSide,
                          widget.width,
                          widget.smallText)),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
