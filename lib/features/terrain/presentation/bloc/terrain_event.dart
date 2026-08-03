import 'package:equatable/equatable.dart';

sealed class TerrainEvent extends Equatable {
  const TerrainEvent();

  @override
  List<Object?> get props => [];
}

class TerrainLocationUpdated extends TerrainEvent {
  const TerrainLocationUpdated({
    required this.latitude,
    required this.longitude,
    required this.altitudeMsl,
  });
  final double latitude;
  final double longitude;
  final double altitudeMsl;

  @override
  List<Object?> get props => [latitude, longitude, altitudeMsl];
}
