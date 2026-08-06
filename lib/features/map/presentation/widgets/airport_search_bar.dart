import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/features/airport/domain/entities/airport.dart';
import 'package:skynav/features/airport/domain/repositories/airport_repository.dart';
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';
import 'package:skynav/injection.dart';

class AirportSearchBar extends StatefulWidget {
  const AirportSearchBar({super.key});

  @override
  State<AirportSearchBar> createState() => _AirportSearchBarState();
}

class _AirportSearchBarState extends State<AirportSearchBar> {
  final AirportRepository _airportRepository = sl<AirportRepository>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: 300,
          child: Autocomplete<Airport>(
            optionsBuilder: (TextEditingValue textEditingValue) async {
              if (textEditingValue.text.isEmpty || textEditingValue.text.length < 2) {
                return const Iterable<Airport>.empty();
              }
              final results = await _airportRepository.searchAirports(textEditingValue.text);
              return results;
            },
            displayStringForOption: (Airport option) => '${option.icao} - ${option.name}',
            onSelected: (Airport selection) {
              // Set the destination when an airport is selected
              context.read<TelemetryBloc>().add(
                TelemetryDestinationSet(
                  LatLng(selection.latitude, selection.longitude),
                ),
              );
              // Hide keyboard
              FocusScope.of(context).unfocus();
            },
            fieldViewBuilder: (
              BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted,
            ) {
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                style: const TextStyle(color: AppTheme.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search Airports...',
                  hintStyle: const TextStyle(color: AppTheme.textSecondary),
                  prefixIcon: const Icon(Icons.search, color: AppTheme.accentPrimary),
                  filled: true,
                  fillColor: AppTheme.backgroundSecondary.withValues(alpha: 0.9),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppTheme.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppTheme.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppTheme.accentPrimary),
                  ),
                ),
              );
            },
            optionsViewBuilder: (
              BuildContext context,
              AutocompleteOnSelected<Airport> onSelected,
              Iterable<Airport> options,
            ) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  color: Colors.transparent,
                  child: Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundSecondary.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      separatorBuilder: (context, index) => const Divider(height: 1, color: AppTheme.border),
                      itemBuilder: (BuildContext context, int index) {
                        final option = options.elementAt(index);
                        return ListTile(
                          title: Text(
                            option.icao,
                            style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            option.name,
                            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(Icons.local_airport, color: AppTheme.textTertiary, size: 16),
                          onTap: () {
                            onSelected(option);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
