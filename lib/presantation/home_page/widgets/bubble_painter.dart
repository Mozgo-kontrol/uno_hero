import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Bubble{
  double x;
  double y;
  double radius;
  double dx;
  double dy;
  Color color;

  Bubble(this.x, this.y, this.radius, this.dx, this.dy, this.color);
}

class BubblePainter extends CustomPainter {
  List<Bubble> bubbles;
  BubblePainter(this.bubbles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      var paint = Paint()
        ..color = bubble.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(bubble.x, bubble.y), bubble.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}



