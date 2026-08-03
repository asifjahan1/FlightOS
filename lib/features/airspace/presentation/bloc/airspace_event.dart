import 'package:equatable/equatable.dart';

sealed class AirspaceEvent extends Equatable {
  const AirspaceEvent();

  @override
  List<Object?> get props => [];
}

class AirspacesLoaded extends AirspaceEvent {}

class AirspaceLocationUpdated extends AirspaceEvent {
  final double latitude;
  final double longitude;
  final double altitude; // feet MSL

  const AirspaceLocationUpdated({
    required this.latitude,
    required this.longitude,
    required this.altitude,
  });

  @override
  List<Object?> get props => [latitude, longitude, altitude];
}
