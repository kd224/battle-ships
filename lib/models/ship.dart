// ignore_for_file: public_member_api_docs, sort_constructors_first
class Ship {
  final int id;
  final double x;
  final double y;
  final int squares;

  Ship(this.id, this.x, this.y, this.squares);

  @override
  String toString() {
    return 'Ship(id: $id, x: $x, y: $y, squares: $squares)';
  }

  Ship copyWith({
    int? id,
    double? x,
    double? y,
    int? squares,
  }) {
    return Ship(
      id ?? this.id,
      x ?? this.x,
      y ?? this.y,
      squares ?? this.squares,
    );
  }
}
