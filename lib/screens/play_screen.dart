import 'package:battle_ships/models/ship.dart';
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
  Ship? _currentShip;
  double l = 0.0;
  double t = 0.0;
  Map<int, int> misalignedShips = {};

  final List<Ship> _ships = [
    Ship(id: 1, rect: const Rect.fromLTWH(50, 50, 50, 200)),
    Ship(id: 2, rect: const Rect.fromLTWH(150, 50, 50, 150)),
    Ship(id: 3, rect: const Rect.fromLTWH(250, 50, 150, 50)),
  ];

  // Detecting if ship is placed in wrong place:
  //
  // Each ship must have one square space from other ships, otherwise it is misaligned.
  // So we artificially enlarge each ship one square in each side.
  // If the enlarged ship touches or runs over another ship, it is wrongly positioned.
  void _detectMisplacedShips() {
    List<int> occuredKeys = [];
    for (final a in _ships) {
      final enlargedShip = a.rect.inflate(50);
      final shipA = _ships.firstWhere((e) => e.id == a.id);

      for (final b in _ships) {
        if (b.id != a.id && b.id > a.id) {
          final shipB = _ships.firstWhere((e) => e.id == b.id);

          if (enlargedShip.overlaps(b.rect)) {
            shipA.isMisaligned = true;
            shipB.isMisaligned = true;
          } else {
            if (!occuredKeys.contains(a.id)) {
              shipA.isMisaligned = false;
            }
            if (!occuredKeys.contains(b.id)) {
              shipB.isMisaligned = false;
            }
          }

          occuredKeys.addAll([a.id, b.id]);
        }
      }
    }
  }

  double _findNearest50(double number) {
    final quotient = number / 50;
    final res = quotient.round() * 50;

    return res.toDouble();
  }

  void _savePosition({double? width, double? height}) {
    if (_currentShip != null) {
      final ship = _ships.firstWhere((e) => e.id == _currentShip!.id);

      final newRect = Rect.fromLTWH(
        l,
        t,
        width ?? ship.rect.width,
        height ?? ship.rect.height,
      );
      _ships.firstWhere((e) => e.id == _currentShip!.id).rect = newRect;
    }
  }

  // A way to find id of currently chosen ship.
  Ship? _findShipId(double x, double y) {
    Rect myRect = Rect.fromCenter(
      center: Offset(x, y),
      width: 3,
      height: 3,
    );

    return _ships.firstWhereOrNull(
      (e) => myRect.overlaps(e.rect),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onPanStart: (details) {
            _currentShip = _findShipId(
              details.localPosition.dx,
              details.localPosition.dy,
            );

            setState(() {
              l = details.localPosition.dx - _currentShip!.rect.width / 2;
              t = details.localPosition.dy - _currentShip!.rect.height / 2;
            });
          },
          onPanEnd: (details) {
            setState(() {
              // Prevent to put ship outside grid.
              if (l > 500) l = (500 - _currentShip!.rect.width);
              if (t > 500) t = (500 - _currentShip!.rect.height);
              if (l < 0) l = 0;
              if (t < 0) t = 0;

              // Attract ship to center of a tile.
              l = _findNearest50(l);
              t = _findNearest50(t);

              _savePosition();

              _detectMisplacedShips();

              _currentShip = null;
            });
          },
          onPanUpdate: (details) {
            setState(() {
              l += details.delta.dx;
              t += details.delta.dy;

              _savePosition();
            });
          },
          onDoubleTapDown: (details) {
            // Changing ship axis orientation.
            _currentShip = _findShipId(
              details.localPosition.dx,
              details.localPosition.dy,
            );

            if (_currentShip != null) {
              setState(() {
                l = _currentShip!.rect.left;
                t = _currentShip!.rect.top;

                // Swaping width with height.
                _savePosition(
                  width: _currentShip?.rect.height,
                  height: _currentShip?.rect.width,
                );

                _detectMisplacedShips();
              });
            }

            _currentShip = null;
          },
          onDoubleTap: () {
            // https://stackoverflow.com/questions/63228704/get-details-on-doubletap-on-flutter-gesturedetector
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
