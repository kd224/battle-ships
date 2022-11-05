import 'package:battle_ships/services/ship_repository.dart';
import 'package:battle_ships/widgets/grid_painter.dart';
import 'package:battle_ships/widgets/ship_painter.dart';
import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  ShipRepository shipRepository = ShipRepository();

  @override
  void initState() {
    super.initState();
    shipRepository.shuffleShips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onPanStart: (details) {
            setState(() {
              shipRepository.onStart(
                details.localPosition.dx,
                details.localPosition.dy,
              );
            });
          },
          onPanEnd: (details) {
            setState(() {
              shipRepository.onEnd();
            });
          },
          onPanUpdate: (details) {
            setState(() {
              shipRepository.onUpdate(
                details.delta.dx,
                details.delta.dy,
              );
            });
          },
          onDoubleTapDown: (details) {
            setState(() {
              shipRepository.rotateShip(
                details.localPosition.dx,
                details.localPosition.dy,
              );
            });
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
              foregroundPainter: ShipPainter(shipRepository.ships),
            ),
          ),
        ),
      ),
    );
  }
}
