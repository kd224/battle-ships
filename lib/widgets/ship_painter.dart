import 'package:battle_ships/models/ship.dart';
import 'package:flutter/material.dart';

class ShipPainter extends CustomPainter {
  final List<Ship> ships;

  ShipPainter(this.ships);

  @override
  void paint(Canvas canvas, Size size) {
    for (final ship in ships) {
      canvas.drawRect(
        ship.rect,
        Paint()..color = !ship.isMisaligned ? Colors.blue : Colors.red,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
