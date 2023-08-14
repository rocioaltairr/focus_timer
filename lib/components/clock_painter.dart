import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final double screenHeight;
  final double screenWidth;
  final Color color;
  int outlineWidth = 10;

  ClockPainter(this.screenHeight, this.screenWidth, this.color);
  @override
  void paint(Canvas canvas, Size size) {
    double heightDeductAppBarHeight =  screenHeight/2 - 100;
    double circleWidth = screenWidth * 2 / 5;
    var paintOutline = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset( (screenWidth)/2, heightDeductAppBarHeight), circleWidth+outlineWidth, paintOutline);
    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset( screenWidth/2, heightDeductAppBarHeight), circleWidth, paint1);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}