import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skynav/features/checklist/presentation/bloc/checklist_bloc.dart';

class ChecklistPanel extends StatelessWidget {
  const ChecklistPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistBloc, ChecklistState>(
      builder: (context, state) {
        if (state is! ChecklistLoaded || !state.isPanelVisible) {
          return const SizedBox.shrink();
        }

        final activeChecklist = state.checklists[state.activeIndex];

        return Container(
          width: 350,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2127).withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Checklist',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () {
                        context.read<ChecklistBloc>().add(ToggleChecklistPanel());
                      },
                    ),
                  ],
                ),
              ),
              // Checklist Selection
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  itemCount: state.checklists.length,
                  itemBuilder: (context, index) {
                    final checklist = state.checklists[index];
                    final isActive = index == state.activeIndex;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(checklist.title),
                        selected: isActive,
                        onSelected: (selected) {
                          if (selected) {
                            context.read<ChecklistBloc>().add(SelectChecklist(index));
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              // Items
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: activeChecklist.items.length,
                  itemBuilder: (context, index) {
                    final item = activeChecklist.items[index];
                    return Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        title: Text(
                          item.title,
                          style: TextStyle(
                            color: item.isCompleted ? Colors.white54 : Colors.white,
                            decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle: item.action != null
                            ? Text(
                                item.action!,
                                style: TextStyle(
                                  color: item.isCompleted ? Colors.blue.withValues(alpha: 0.5) : Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                        value: item.isCompleted,
                        onChanged: (value) {
                          context.read<ChecklistBloc>().add(ToggleChecklistItem(activeChecklist.id, item.id));
                        },
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
