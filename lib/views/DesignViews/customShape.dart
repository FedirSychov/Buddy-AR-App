import 'package:flutter/material.dart';

class CustomShape extends CustomPainter {
  final Color bgColor;
  final bool leftSide;
  final double width;
  final bool smallText;

  CustomShape(this.bgColor, this.leftSide, this.width, this.smallText);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;
    var path = Path();
    var xyAray = [
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0
    ]; //0,1,2 = x1,x2,x3, 3,4,5 = y1,y2,y3

    if (leftSide) {
      xyAray[0] = -width / 4 - 10;
      xyAray[1] = -width / 4 - 20;
      xyAray[2] = -width / 4 - 30;
    } else {
      xyAray[0] = -20;
      xyAray[1] = -30;
      xyAray[2] = -40;
    }

    if (smallText) {
      xyAray[3] = 0;
      xyAray[4] = 30;
      xyAray[5] = 0;
    } else {
      xyAray[3] = 55;
      xyAray[4] = 85;
      xyAray[5] = 55;
    }

    path.lineTo(xyAray[0], xyAray[3]);
    path.lineTo(xyAray[1], xyAray[4]);
    path.lineTo(xyAray[2], xyAray[5]);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
