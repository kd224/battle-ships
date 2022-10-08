import 'package:battle_ships/widgets/grid_painter.dart';
import 'package:battle_ships/widgets/ship_painter.dart';
import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool _isClicked = false;
  double x = 75;
  double y = 75;

  double _findNearest50(double number) {
    final quotient = number / 50;
    final res = quotient.round() * 50;

    return number < res ? res - 25 : res + 25;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onPanStart: (details) {
            setState(() {
              _isClicked = true;
              x = details.localPosition.dx;
              y = details.localPosition.dy;
            });
          },
          onPanEnd: (details) {
            setState(() {
              _isClicked = false;

              // Prevent to put ship outside grid.
              if (x > 500) x = 475;
              if (y > 500) y = 475;
              if (x < 0) x = 25;
              if (y < 0) y = 25;

              x = _findNearest50(x);
              y = _findNearest50(y);
            });
          },
          onPanUpdate: (details) {
            if (_isClicked) {
              setState(() {
                x += details.delta.dx;
                y += details.delta.dy;
              });
            }
          },
          child: Container(
            width: 500,
            height: 500,
            color: Colors.white,
            child: CustomPaint(
              painter: MyGridPainter(),
              foregroundPainter: ShipPainter(x, y),
            ),
          ),
        ),
      ),
    );
  }
}
