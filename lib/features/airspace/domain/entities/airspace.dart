import 'package:equatable/equatable.dart';

class Airspace extends Equatable {
  // List of [lat, lon]

  const Airspace({
    required this.id,
    required this.name,
    required this.type,
    required this.floorAltitude,
    required this.ceilingAltitude,
    required this.boundary,
  });
  final String id;
  final String name;
  final String type;
  final int floorAltitude; // feet MSL
  final int ceilingAltitude; // feet MSL
  final List<List<double>> boundary;

  @override
  List<Object?> get props => [
    id,
    name,
    type,
    floorAltitude,
    ceilingAltitude,
    boundary,
  ];

  // Helper method to check if a point is inside the polygon (Ray-casting algorithm)
  bool contains(double lat, double lon) {
    var isInside = false;
    for (var i = 0, j = boundary.length - 1; i < boundary.length; j = i++) {
      final latI = boundary[i][0];
      final lonI = boundary[i][1];
      final latJ = boundary[j][0];
      final lonJ = boundary[j][1];

      final intersect =
          ((lonI > lon) != (lonJ > lon)) &&
          (lat < (latJ - latI) * (lon - lonI) / (lonJ - lonI) + latI);
      if (intersect) isInside = !isInside;
    }
    return isInside;
  }
}
