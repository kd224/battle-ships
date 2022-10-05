import 'package:flutter/material.dart';

class ShipPainter extends CustomPainter {
  final double xAxis;
  final double yAxis;

  ShipPainter(this.xAxis, this.yAxis);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(xAxis, yAxis),
        width: 50,
        height: 50,
      ),
      Paint()..color = Colors.blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
