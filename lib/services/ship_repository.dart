// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:battle_ships/models/ship.dart';
import 'package:battle_ships/utils/get_max_number.dart';
import 'package:flutter/painting.dart';
import 'package:collection/collection.dart';

class ShipRepository {
  Ship? currentShip;
  double l = 0.0;
  double t = 0.0;

  final List<Ship> ships = [
    Ship(id: 1, rect: const Rect.fromLTWH(-50, -50, 50, 200)),
    Ship(id: 2, rect: const Rect.fromLTWH(-50, -50, 50, 150)),
    Ship(id: 3, rect: const Rect.fromLTWH(-50, -50, 50, 150)),
    Ship(id: 4, rect: const Rect.fromLTWH(-50, -50, 50, 100)),
    Ship(id: 5, rect: const Rect.fromLTWH(-50, -50, 50, 100)),
    Ship(id: 6, rect: const Rect.fromLTWH(-50, -50, 50, 100)),
    Ship(id: 7, rect: const Rect.fromLTWH(-50, -50, 50, 50)),
    Ship(id: 8, rect: const Rect.fromLTWH(-50, -50, 50, 50)),
    Ship(id: 9, rect: const Rect.fromLTWH(-50, -50, 50, 50)),
    Ship(id: 10, rect: const Rect.fromLTWH(-50, -50, 50, 50)),
  ];

  // A way to find currently clicked ship.
  // We may also click a blank tile, it will results with null value.
  Ship? findCurrentShip(double x, double y) {
    Rect myRect = Rect.fromCenter(
      center: Offset(x, y),
      width: 3,
      height: 3,
    );

    return ships.firstWhereOrNull(
      (e) => myRect.overlaps(e.rect),
    );
  }

  void saveShipPosition({double? width, double? height}) {
    if (currentShip != null) {
      final ship = ships.firstWhere((e) => e.id == currentShip!.id);

      final newRect = Rect.fromLTWH(
        l,
        t,
        width ?? ship.rect.width,
        height ?? ship.rect.height,
      );
      ships.firstWhere((e) => e.id == currentShip!.id).rect = newRect;
    }
  }

  double findNearest50(double number) {
    final quotient = number / 50;
    final res = quotient.round() * 50;

    return res.toDouble();
  }

  // Detecting if ship is placed in wrong place:
  //
  // Each ship must have one square space from other ships, otherwise it is misaligned.
  // So we artificially enlarge each ship one square in each side.
  // If the enlarged ship touches or runs over another ship, it is wrongly positioned.
  void _detectMisplacedShips() {
    List<int> occuredKeys = [];
    for (final a in ships) {
      final enlargedShip = a.rect.inflate(50);
      final shipA = ships.firstWhere((e) => e.id == a.id);

      for (final b in ships) {
        if (b.id != a.id && b.id > a.id) {
          final shipB = ships.firstWhere((e) => e.id == b.id);

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

  bool _isOverlap(Ship ship) {
    final enlargedShip = ship.rect.inflate(50);
    bool isOverlap = false;

    for (final theShip in ships) {
      if (ship.id != theShip.id && theShip.id < ship.id) {
        if (enlargedShip.overlaps(theShip.rect)) {
          isOverlap = true;
          break;
        }
      }
    }

    return isOverlap;
  }

  int _getRandomNumber(int max) {
    const min = 0;

    return min + Random().nextInt(max - min);
  }

  void getRandomShipOrientation() {}

  void _placeRandom(Ship ship) {
    double w, h;
    final rand = _getRandomNumber(2);

    // Get random orientation of the ship.
    if (rand == 1) {
      w = ship.rect.width;
      h = ship.rect.height;
    } else {
      h = ship.rect.width;
      w = ship.rect.height;
    }

    // getMaxNumber prevent to put ship outside the grid.
    final l = _getRandomNumber(getMaxNumber(w)) * 50.0;
    final t = _getRandomNumber(getMaxNumber(h)) * 50.0;

    final newRect = Rect.fromLTWH(l, t, w, h);
    ship.rect = newRect;
  }

  void shuffleShips() {
    for (final ship in ships) {
      _placeRandom(ship);

      while (_isOverlap(ship)) {
        _placeRandom(ship);
      }
    }
  }

  void onStart(double x, double y) {
    currentShip = findCurrentShip(x, y);

    l = x - currentShip!.rect.width / 2;
    t = y - currentShip!.rect.height / 2;
  }

  void onUpdate(double x, double y) {
    l += x;
    t += y;

    saveShipPosition();
  }

  void onEnd() {
    if (l > 500) l = (500 - currentShip!.rect.width);
    if (t > 500) t = (500 - currentShip!.rect.height);
    if (l < 0) l = 0;
    if (t < 0) t = 0;

    l = findNearest50(l);
    t = findNearest50(t);

    saveShipPosition();

    _detectMisplacedShips();

    currentShip = null;
  }

  void rotateShip(double x, double y) {
    currentShip = findCurrentShip(x, y);

    if (currentShip != null) {
      l = currentShip!.rect.left;
      t = currentShip!.rect.top;

      // Swaping width with height.
      saveShipPosition(
        width: currentShip?.rect.height,
        height: currentShip?.rect.width,
      );

      _detectMisplacedShips();
    }

    currentShip = null;
  }
}
