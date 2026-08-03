import 'package:equatable/equatable.dart';
import 'package:skynav/features/airspace/domain/entities/airspace.dart';

sealed class AirspaceState extends Equatable {
  const AirspaceState();

  @override
  List<Object?> get props => [];
}

class AirspaceInitial extends AirspaceState {}

class AirspaceLoading extends AirspaceState {}

class AirspaceLoaded extends AirspaceState {
  final List<Airspace> airspaces;
  final Airspace? currentAlert; // The airspace the aircraft is currently inside

  const AirspaceLoaded({
    required this.airspaces,
    this.currentAlert,
  });

  AirspaceLoaded copyWith({
    List<Airspace>? airspaces,
    Airspace? currentAlert,
    bool clearAlert = false,
  }) {
    return AirspaceLoaded(
      airspaces: airspaces ?? this.airspaces,
      currentAlert: clearAlert ? null : (currentAlert ?? this.currentAlert),
    );
  }

  @override
  List<Object?> get props => [airspaces, currentAlert];
}

class AirspaceError extends AirspaceState {
  final String message;
  const AirspaceError(this.message);

  @override
  List<Object?> get props => [message];
}
