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
  double l = 0.0;
  double t = 0.0;

  final Map<int, Map<String, dynamic>> _ships = {
    1: {'l': 50.0, 't': 50.0, 'w': 50.0, 'h': 200.0},
    2: {'l': 150.0, 't': 50.0, 'w': 50.0, 'h': 150.0},
    3: {'l': 250.0, 't': 50.0, 'w': 150.0, 'h': 50.0},
  };

  double _findNearest50(double number) {
    final quotient = number / 50;
    final res = quotient.round() * 50;

    return res.toDouble();
  }

  void _savePosition() {
    if (_shipId != null) {
      _ships[_shipId]!['l'] = l;
      _ships[_shipId]!['t'] = t;
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
              width: 3,
              height: 3,
            );

            _shipId = _ships.keys.firstWhereOrNull((e) {
              final l = _ships[e]?['l'] as double;
              final t = _ships[e]?['t'] as double;
              final w = _ships[e]?['w'] as double;
              final h = _ships[e]?['h'] as double;

              final newRect = Rect.fromLTWH(l, t, w, h);

              return myReact.overlaps(newRect);
            });

            setState(() {
              l = details.localPosition.dx - (_ships[_shipId]!['w'] / 2);
              t = details.localPosition.dy - (_ships[_shipId]!['h'] / 2);
            });
          },
          onPanEnd: (details) {
            setState(() {
              // Prevent to put ship outside grid.
              if (l > 500) l = (500 - _ships[_shipId]!['w']).toDouble();
              if (t > 500) t = (500 - _ships[_shipId]!['h']).toDouble();
              if (l < 0) l = 0;
              if (t < 0) t = 0;

              // Attract ship to center of a tile.
              l = _findNearest50(l);
              t = _findNearest50(t);

              _savePosition();

              _shipId = null;
            });
          },
          onPanUpdate: (details) {
            setState(() {
              l += details.delta.dx;
              t += details.delta.dy;

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
