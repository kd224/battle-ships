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
      body: GestureDetector(
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: CustomPaint(
            painter: MyGridPainter(),
            foregroundPainter: ShipPainter(x, y),
          ),
        ),
      ),
    );
  }
}
