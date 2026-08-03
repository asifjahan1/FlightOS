import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skynav/features/scratchpad/presentation/bloc/scratchpad_bloc.dart';

class ScratchpadPanel extends StatelessWidget {
  const ScratchpadPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScratchpadBloc, ScratchpadState>(
      builder: (context, state) {
        if (state is! ScratchpadLoaded || !state.isVisible) {
          return const SizedBox.shrink();
        }

        return Container(
          width: 300,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFDFBF7), // Yellowish paper color
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.brown.withValues(alpha: 0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.brown.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ATC Scratchpad',
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.clear_all, color: Colors.brown, size: 20),
                          tooltip: 'Clear',
                          onPressed: () {
                            context.read<ScratchpadBloc>().add(ClearScratchpad());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.brown, size: 20),
                          onPressed: () {
                            context.read<ScratchpadBloc>().add(ToggleScratchpad());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Editor
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: state.text,
                  onChanged: (val) {
                    context.read<ScratchpadBloc>().add(UpdateScratchpadText(val));
                  },
                  maxLines: 8,
                  style: const TextStyle(
                    fontFamily: 'Courier',
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type clearances here...',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
