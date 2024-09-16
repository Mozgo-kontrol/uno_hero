import 'package:flutter/material.dart';

class CustomCardShape extends ShapeBorder {
  final double borderWidth;
  final Color shapeColor;

  const CustomCardShape({this.shapeColor = Colors.green, this.borderWidth = 1.0});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRect(rect.deflate(borderWidth / 2.0));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(10.0))); // Adjust the radius as needed
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = shapeColor // Set the desired gray color
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(getOuterPath(rect), paint);
  }

  @override
  ShapeBorder scale(double t) {
    return CustomCardShape(borderWidth: borderWidth * t);
  }
}