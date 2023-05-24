import 'package:BUDdy/model/EnumSpeechBubbles.dart';
import 'package:BUDdy/views/DesignViews/customShape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SpeechBubble extends StatefulWidget {
  bool withAnimation;
  BubbleType type;
  var context;
  late double width;

  SpeechBubble(this.withAnimation, this.type, this.context) {
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
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.withAnimation ? 1 : 0));
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
              mainAxisAlignment: widget.type.leftSide
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                      width: widget.type.smallText ? 180 : 200,
                      height: widget.type.smallText ? 60 : 106,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                            topRight: Radius.circular(18)),
                      ),
                      child: Center(
                        child: Text(
                          widget.type.message,
                          style: widget.type.smallText
                              ? Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)
                              : Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50, right: 20),
                  child: CustomPaint(
                      painter: CustomShape(
                          widget.type.message.length,
                          Theme.of(context).colorScheme.inverseSurface,
                          widget.type.leftSide,
                          widget.width,
                          widget.type.smallText)),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
