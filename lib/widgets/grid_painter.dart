import 'package:battle_ships/utils/alphabet_notation.dart';
import 'package:flutter/material.dart';

class MyGridPainter extends CustomPainter {
  TextPainter _getNotationText(String text) {
    TextSpan span = TextSpan(
      style: const TextStyle(
        color: Colors.tealAccent,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      text: text,
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.end,
      textDirection: TextDirection.ltr,
    );

    return tp;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()..color = Colors.grey[500]!;

    // Drawing a grid.
    for (double i = 0; i <= 10; i++) {
      // Vertical lines.
      canvas.drawLine(Offset(i * 50, 0), Offset(i * 50, 500), linePaint);

      // Horizontal lines.
      canvas.drawLine(Offset(500, i * 50), Offset(0, i * 50), linePaint);

      if (i < 10) {
        final numbers = _getNotationText((i + 1).toInt().toString());
        numbers.layout();
        numbers.paint(canvas, Offset(-30, i * 50 + 15));

        final letters = _getNotationText(alphabetNotation[i.toInt()]);
        letters.layout();
        letters.paint(canvas, Offset(i * 50 + 20, -30));
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
