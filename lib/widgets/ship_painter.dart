import 'package:flutter/material.dart';

class ShipPainter extends CustomPainter {
  final Map<int, Map<String, dynamic>> ships;

  ShipPainter(this.ships);

  @override
  void paint(Canvas canvas, Size size) {
    for (final key in ships.keys) {
      final l = ships[key]!['l'] as double;
      final t = ships[key]!['t'] as double;
      final w = ships[key]!['w'] as double;
      final h = ships[key]!['h'] as double;

      canvas.drawRect(
        Rect.fromLTWH(l, t, w, h),
        Paint()..color = Colors.blue,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
