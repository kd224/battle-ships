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
