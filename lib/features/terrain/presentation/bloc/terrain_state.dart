import 'package:equatable/equatable.dart';

sealed class TerrainState extends Equatable {
  const TerrainState();

  @override
  List<Object?> get props => [];
}

class TerrainInitial extends TerrainState {}

class TerrainUpdated extends TerrainState {
  const TerrainUpdated({
    required this.currentElevation,
    required this.agl,
    required this.isTawsAlertActive,
  });
  final double currentElevation; // MSL
  final double agl; // Above Ground Level
  final bool isTawsAlertActive;

  @override
  List<Object?> get props => [currentElevation, agl, isTawsAlertActive];
}
