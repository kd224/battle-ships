import 'package:battle_ships/widgets/grid_painter.dart';
import 'package:battle_ships/widgets/ship_painter.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late int? _shipId;
  double x = 0.0;
  double y = 0.0;

  final Map<int, Map<String, dynamic>> _ships = {
    1: {'x': 25.0, 'y': 125.0},
    2: {'x': 125.0, 'y': 75.0},
    3: {'x': 225.0, 'y': 75.0},
  };

  double _findNearest50(double number) {
    final quotient = number / 50;
    final res = quotient.round() * 50;

    return number < res ? res - 25 : res + 25;
  }

  void _savePosition() {
    if (_shipId != null) {
      _ships[_shipId]!['x'] = x;
      _ships[_shipId]!['y'] = y;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onPanStart: (details) {
            // A way to find id of currently chosen ship.
            Rect myReact = Rect.fromCenter(
              center: Offset(
                details.localPosition.dx,
                details.localPosition.dy,
              ),
              width: 50,
              height: 50,
            );

            _shipId = _ships.keys.firstWhereOrNull((e) {
              final x = _ships[e]?['x'] as double;
              final y = _ships[e]?['y'] as double;

              return myReact.contains(Offset(x, y));
            });

            setState(() {
              x = details.localPosition.dx;
              y = details.localPosition.dy;
            });
          },
          onPanEnd: (details) {
            setState(() {
              // Prevent to put ship outside grid.
              if (x > 500) x = 475;
              if (y > 500) y = 475;
              if (x < 0) x = 25;
              if (y < 0) y = 25;

              // Attract ship to center of a tile.
              x = _findNearest50(x);
              y = _findNearest50(y);

              _savePosition();

              _shipId = null;
            });
          },
          onPanUpdate: (details) {
            setState(() {
              x += details.delta.dx;
              y += details.delta.dy;

              _savePosition();
            });
          },
          child: Container(
            width: 500,
            height: 500,
            color: Colors.white,
            child: CustomPaint(
              painter: MyGridPainter(),
              foregroundPainter: ShipPainter(_ships),
            ),
          ),
        ),
      ),
    );
  }
}
