import 'package:flutter/material.dart';

class ShipPainter extends CustomPainter {
  final Map<int, Map<String, dynamic>> ships;

  ShipPainter(this.ships);

  @override
  void paint(Canvas canvas, Size size) {
    for (final key in ships.keys) {
      final x = ships[key]!['x'] as double;
      final y = ships[key]!['y'] as double;
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(x, y),
          width: 50,
          height: 50,
        ),
        Paint()..color = Colors.blue,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
