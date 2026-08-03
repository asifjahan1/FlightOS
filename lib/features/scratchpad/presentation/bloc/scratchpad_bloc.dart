import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// State
sealed class ScratchpadState extends Equatable {
  const ScratchpadState();
  @override
  List<Object?> get props => [];
}

class ScratchpadLoaded extends ScratchpadState {

  const ScratchpadLoaded({this.text = '', this.isVisible = false});
  final String text;
  final bool isVisible;

  ScratchpadLoaded copyWith({String? text, bool? isVisible}) {
    return ScratchpadLoaded(
      text: text ?? this.text,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object?> get props => [text, isVisible];
}

// Event
sealed class ScratchpadEvent extends Equatable {
  const ScratchpadEvent();
  @override
  List<Object?> get props => [];
}

class ToggleScratchpad extends ScratchpadEvent {}
class UpdateScratchpadText extends ScratchpadEvent {
  const UpdateScratchpadText(this.text);
  final String text;
  @override
  List<Object?> get props => [text];
}
class ClearScratchpad extends ScratchpadEvent {}

// Bloc
@injectable
class ScratchpadBloc extends Bloc<ScratchpadEvent, ScratchpadState> {
  ScratchpadBloc() : super(const ScratchpadLoaded()) {
    on<ToggleScratchpad>((event, emit) {
      if (state is ScratchpadLoaded) {
        final s = state as ScratchpadLoaded;
        emit(s.copyWith(isVisible: !s.isVisible));
      }
    });
    on<UpdateScratchpadText>((event, emit) {
      if (state is ScratchpadLoaded) {
        emit((state as ScratchpadLoaded).copyWith(text: event.text));
      }
    });
    on<ClearScratchpad>((event, emit) {
      if (state is ScratchpadLoaded) {
        emit((state as ScratchpadLoaded).copyWith(text: ''));
      }
    });
  }
}
