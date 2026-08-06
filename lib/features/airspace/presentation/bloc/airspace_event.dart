import 'package:equatable/equatable.dart';

sealed class AirspaceEvent extends Equatable {
  const AirspaceEvent();

  @override
  List<Object?> get props => [];
}

class AirspacesLoaded extends AirspaceEvent {
  const AirspacesLoaded({
    required this.latMin,
    required this.lonMin,
    required this.latMax,
    required this.lonMax,
  });

  final double latMin;
  final double lonMin;
  final double latMax;
  final double lonMax;

  @override
  List<Object?> get props => [latMin, lonMin, latMax, lonMax];
}

class AirspaceLocationUpdated extends AirspaceEvent {
  // feet MSL

  const AirspaceLocationUpdated({
    required this.latitude,
    required this.longitude,
    required this.altitude,
  });
  final double latitude;
  final double longitude;
  final double altitude;

  @override
  List<Object?> get props => [latitude, longitude, altitude];
}
