import 'package:flutter/material.dart';

class MyGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()..color = Colors.grey[500]!;

    // Drawing a grid.
    for (double i = 0; i <= 10; i++) {
      // Vertical lines.
      canvas.drawLine(Offset(i * 50, 0), Offset(i * 50, 500), linePaint);

      // Horizontal lines.
      canvas.drawLine(Offset(500, i * 50), Offset(0, i * 50), linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
