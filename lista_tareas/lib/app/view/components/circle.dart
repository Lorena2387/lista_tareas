import 'package:flutter/material.dart';

class CirclePainter extends CustomPaint {
  void paint(Canvas canvas, Size size) {
    final outerCircle = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    canvas.drawCircle(const Offset(50, 50), 80, outerCircle);

    final innerCircle = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(50, 50), 60, innerCircle);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
