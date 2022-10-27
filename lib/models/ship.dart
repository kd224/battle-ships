// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/painting.dart';

class Ship {
  int id;
  Rect rect;
  bool isMisaligned;

  Ship({
    required this.id,
    required this.rect,
    this.isMisaligned = false,
  });

  Ship copyWith({
    int? id,
    Rect? rect,
    bool? isMisaligned,
  }) {
    return Ship(
      id: id ?? this.id,
      rect: rect ?? this.rect,
      isMisaligned: isMisaligned ?? this.isMisaligned,
    );
  }

  @override
  String toString() =>
      'Ship(id: $id, rect: $rect, isMisaligned: $isMisaligned)';
}
