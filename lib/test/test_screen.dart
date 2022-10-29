// // import 'package:battle_ships/widgets/ship_painter.dart';
// // import 'package:flutter/material.dart';

// // class TestScreen extends StatefulWidget {
// //   const TestScreen({Key? key}) : super(key: key);

// //   @override
// //   State<TestScreen> createState() => _TestScreenState();
// // }

// // class _TestScreenState extends State<TestScreen> {
// //   bool _isClicked = false;
// //   double x = 75;
// //   double y = 75;

// //   double _findNearest50(double number) {
// //     final quotient = number / 50;
// //     final res = quotient.round() * 50;

// //     return number < res ? res - 25 : res + 25;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: GestureDetector(
// //         onPanStart: (details) {
// //           setState(() {
// //             _isClicked = true;
// //             x = details.localPosition.dx;
// //             y = details.localPosition.dy;
// //           });
// //         },
// //         onPanEnd: (details) {
// //           setState(() {
// //             // if (x > 500) x = 475;
// //             // if (y > 500) y = 475;

// //             _isClicked = false;
// //           });
// //         },
// //         onPanUpdate: (details) {
// //           if (_isClicked) {
// //             setState(() {
// //               x += details.delta.dx;
// //               y += details.delta.dy;
// //             });
// //           }
// //         },
// //         child: Center(
// //           child: Container(
// //             width: MediaQuery.of(context).size.width,
// //             height: MediaQuery.of(context).size.height,
// //             color: Colors.grey,
// //             child: CustomPaint(
// //               painter: ShipPainter(x, y),
// //               //size: const Size(500, 500),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// final enlargedShipa = _constructShip(_ships[1]).inflate(50);
//               final otherShipa = _constructShip(_ships[2]);
//               if (enlargedShipa.overlaps(otherShipa)) {
//                 _ships[1]!['isRed'] = true;
//               } else {
//                 _ships[1]!['isRed'] = false;
//               }

//               final enlargedShipb = _constructShip(_ships[2]).inflate(50);
//               final otherShipb = _constructShip(_ships[1]);
//               if (enlargedShipb.overlaps(otherShipb)) {
//                 _ships[2]!['isRed'] = true;
//               } else {
//                 _ships[2]!['isRed'] = false;
//               }

//               //

//               final enlargedShipc = _constructShip(_ships[1]).inflate(50);
//               final otherShipc = _constructShip(_ships[3]);
//               if (enlargedShipc.overlaps(otherShipc)) {
//                 _ships[1]!['isRed'] = true;
//               } else {
//                 if (!_ships[1]!['isRed']) _ships[1]!['isRed'] = false;
//               }

//               final enlargedShipd = _constructShip(_ships[3]).inflate(50);
//               final otherShipd = _constructShip(_ships[1]);
//               if (enlargedShipd.overlaps(otherShipd)) {
//                 _ships[3]!['isRed'] = true;
//               } else {
//                 _ships[3]!['isRed'] = false;
//               }

//               //

//               final enlargedShipe = _constructShip(_ships[2]).inflate(50);
//               final otherShipe = _constructShip(_ships[3]);
//               if (enlargedShipe.overlaps(otherShipe)) {
//                 _ships[2]!['isRed'] = true;
//               } else {
//                 if (!_ships[2]!['isRed']) _ships[2]!['isRed'] = false;
//               }

//               final enlargedShipf = _constructShip(_ships[3]).inflate(50);
//               final otherShipf = _constructShip(_ships[2]);
//               if (enlargedShipf.overlaps(otherShipf)) {
//                 _ships[3]!['isRed'] = true;
//               } else {
//                 if (!_ships[3]!['isRed']) _ships[3]!['isRed'] = false;
//               }

//
//
//
//
///
///
///
///
///
///
///
//               final enlargedShipa = _constructShip(_ships[1]).inflate(50);
//               final otherShipa = _constructShip(_ships[2]);
//               if (enlargedShipa.overlaps(otherShipa)) {
//                 _ships[1]!['isRed'] = true;
//                 _ships[2]!['isRed'] = true;
//               } else {
//                 _ships[1]!['isRed'] = false;
//                 _ships[2]!['isRed'] = false;
//               }

//               final enlargedShipb = _constructShip(_ships[1]).inflate(50);
//               final otherShipb = _constructShip(_ships[3]);
//               if (enlargedShipb.overlaps(otherShipb)) {
//                 _ships[1]!['isRed'] = true;
//                 _ships[3]!['isRed'] = true;
//               } else {
//                 if (!_ships[1]!['isRed']) _ships[1]!['isRed'] = false;
//                 _ships[3]!['isRed'] = false;
//               }

//               final enlargedShipc = _constructShip(_ships[2]).inflate(50);
//               final otherShipc = _constructShip(_ships[3]);
//               if (enlargedShipc.overlaps(otherShipc)) {
//                 _ships[2]!['isRed'] = true;
//                 _ships[3]!['isRed'] = true;
//               } else {
//                 if (!_ships[2]!['isRed']) _ships[2]!['isRed'] = false;
//                 if (!_ships[3]!['isRed']) _ships[3]!['isRed'] = false;
//               }