import 'package:equatable/equatable.dart';

class FleetTarget extends Equatable {
  const FleetTarget({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.updatedAt,
    this.destinationLatitude,
    this.destinationLongitude,
  });

  factory FleetTarget.fromJson(Map<String, dynamic> json) {
    return FleetTarget(
      id: json['id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      altitude: (json['altitude'] as num).toDouble(),
      heading: (json['heading'] as num).toDouble(),
      speed: (json['speed'] as num).toDouble(),
      updatedAt: DateTime.parse(json['updated_at'] as String).toLocal(),
      destinationLatitude: json['dest_lat'] != null ? (json['dest_lat'] as num).toDouble() : null,
      destinationLongitude: json['dest_lng'] != null ? (json['dest_lng'] as num).toDouble() : null,
    );
  }

  final String id;
  final double latitude;
  final double longitude;
  final double altitude;
  final double heading;
  final double speed;
  final DateTime updatedAt;
  final double? destinationLatitude;
  final double? destinationLongitude;

  @override
  List<Object?> get props => [
        id,
        latitude,
        longitude,
        altitude,
        heading,
        speed,
        updatedAt,
        destinationLatitude,
        destinationLongitude,
      ];
}
