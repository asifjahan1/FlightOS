import 'package:equatable/equatable.dart';

class ChecklistItem extends Equatable {
  const ChecklistItem({
    required this.id,
    required this.title,
    this.action,
    this.isCompleted = false,
  });
  final String id;
  final String title;
  final String? action;
  final bool isCompleted;

  ChecklistItem copyWith({bool? isCompleted}) {
    return ChecklistItem(
      id: id,
      title: title,
      action: action,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, action, isCompleted];
}

class Checklist extends Equatable {
  const Checklist({required this.id, required this.title, required this.items});
  final String id;
  final String title;
  final List<ChecklistItem> items;

  Checklist copyWith({List<ChecklistItem>? items}) {
    return Checklist(id: id, title: title, items: items ?? this.items);
  }

  @override
  List<Object?> get props => [id, title, items];
}
