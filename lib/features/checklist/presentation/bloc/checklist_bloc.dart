import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skynav/features/checklist/domain/entities/checklist.dart';

// State
sealed class ChecklistState extends Equatable {
  const ChecklistState();
  @override
  List<Object?> get props => [];
}

class ChecklistLoaded extends ChecklistState {
  const ChecklistLoaded({
    required this.checklists,
    this.activeIndex = 0,
    this.isPanelVisible = false,
  });
  final List<Checklist> checklists;
  final int activeIndex;
  final bool isPanelVisible;

  ChecklistLoaded copyWith({
    List<Checklist>? checklists,
    int? activeIndex,
    bool? isPanelVisible,
  }) {
    return ChecklistLoaded(
      checklists: checklists ?? this.checklists,
      activeIndex: activeIndex ?? this.activeIndex,
      isPanelVisible: isPanelVisible ?? this.isPanelVisible,
    );
  }

  @override
  List<Object?> get props => [checklists, activeIndex, isPanelVisible];
}

// Events
sealed class ChecklistEvent extends Equatable {
  const ChecklistEvent();
  @override
  List<Object?> get props => [];
}

class ToggleChecklistPanel extends ChecklistEvent {}

class SelectChecklist extends ChecklistEvent {
  const SelectChecklist(this.index);
  final int index;
  @override
  List<Object?> get props => [index];
}

class ToggleChecklistItem extends ChecklistEvent {
  const ToggleChecklistItem(this.checklistId, this.itemId);
  final String checklistId;
  final String itemId;
  @override
  List<Object?> get props => [checklistId, itemId];
}

// Bloc
@injectable
class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  ChecklistBloc() : super(const ChecklistLoaded(checklists: [])) {
    on<ToggleChecklistPanel>(_onTogglePanel);
    on<SelectChecklist>(_onSelectChecklist);
    on<ToggleChecklistItem>(_onToggleItem);
    _loadInitial();
  }

  void _loadInitial() {
    final initialChecklists = [
      Checklist(
        id: 'c1',
        title: 'Pre-Flight',
        items: [
          ChecklistItem(id: 'i1', title: 'Master Switch', action: 'ON'),
          ChecklistItem(id: 'i2', title: 'Fuel Quantity', action: 'CHECK'),
          ChecklistItem(id: 'i3', title: 'Flaps', action: 'DOWN'),
        ],
      ),
      Checklist(
        id: 'c2',
        title: 'Before Takeoff',
        items: [
          ChecklistItem(
            id: 'i4',
            title: 'Flight Controls',
            action: 'FREE & CORRECT',
          ),
          ChecklistItem(id: 'i5', title: 'Instruments', action: 'SET'),
          ChecklistItem(id: 'i6', title: 'Trim', action: 'SET FOR TAKEOFF'),
        ],
      ),
    ];
    emit(ChecklistLoaded(checklists: initialChecklists));
  }

  void _onTogglePanel(
    ToggleChecklistPanel event,
    Emitter<ChecklistState> emit,
  ) {
    if (state is ChecklistLoaded) {
      final s = state as ChecklistLoaded;
      emit(s.copyWith(isPanelVisible: !s.isPanelVisible));
    }
  }

  void _onSelectChecklist(SelectChecklist event, Emitter<ChecklistState> emit) {
    if (state is ChecklistLoaded) {
      emit((state as ChecklistLoaded).copyWith(activeIndex: event.index));
    }
  }

  void _onToggleItem(ToggleChecklistItem event, Emitter<ChecklistState> emit) {
    if (state is ChecklistLoaded) {
      final s = state as ChecklistLoaded;
      final newLists = s.checklists.map((c) {
        if (c.id == event.checklistId) {
          final newItems = c.items.map((i) {
            if (i.id == event.itemId)
              return i.copyWith(isCompleted: !i.isCompleted);
            return i;
          }).toList();
          return c.copyWith(items: newItems);
        }
        return c;
      }).toList();
      emit(s.copyWith(checklists: newLists));
    }
  }
}
