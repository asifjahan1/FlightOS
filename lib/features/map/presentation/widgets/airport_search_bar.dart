import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:skynav/core/theme/app_theme.dart';
import 'package:skynav/features/airport/domain/entities/airport.dart';
import 'package:skynav/features/airport/domain/repositories/airport_repository.dart';
import 'package:skynav/features/airport/presentation/widgets/airport_details_panel.dart'
    as skynav_panels;
import 'package:skynav/features/telemetry/presentation/bloc/telemetry_bloc.dart';
import 'package:skynav/injection.dart';

class AirportSearchBar extends StatefulWidget {
  const AirportSearchBar({super.key});

  @override
  State<AirportSearchBar> createState() => _AirportSearchBarState();
}

class _AirportSearchBarState extends State<AirportSearchBar> {
  final AirportRepository _airportRepository = sl<AirportRepository>();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Airport> _results = [];
  bool _showDropdown = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    if (query.length < 2) {
      setState(() {
        _results = [];
        _showDropdown = false;
      });
      return;
    }
    final results = await _airportRepository.searchAirports(query);
    if (mounted) {
      setState(() {
        _results = results;
        _showDropdown = results.isNotEmpty;
      });
    }
  }

  void _onSelected(Airport airport) {
    _controller.text = '${airport.icao} - ${airport.name}';
    _focusNode.unfocus();
    setState(() {
      _showDropdown = false;
      _results = [];
    });

    context.read<TelemetryBloc>().add(
      TelemetryDestinationSet(LatLng(airport.latitude, airport.longitude)),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.85,
        child: skynav_panels.AirportDetailsPanel(airport: airport),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use a wider bar on mobile devices
    final isMobile = Platform.isAndroid || Platform.isIOS;
    final barWidth = isMobile ? 260.0 : 300.0;

    return SizedBox(
      width: barWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Search Field ──
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            style: const TextStyle(color: AppTheme.textPrimary),
            onChanged: _search,
            onTap: () {
              if (_results.isNotEmpty) {
                setState(() => _showDropdown = true);
              }
            },
            decoration: InputDecoration(
              hintText: 'Search Airports...',
              hintStyle: const TextStyle(color: AppTheme.textSecondary),
              prefixIcon: const Icon(
                Icons.search,
                color: AppTheme.accentPrimary,
              ),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: AppTheme.textSecondary,
                        size: 18,
                      ),
                      onPressed: () {
                        _controller.clear();
                        setState(() {
                          _results = [];
                          _showDropdown = false;
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: AppTheme.backgroundSecondary.withValues(alpha: 0.9),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
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
          ),

          // ── Dropdown results (rendered inline below the field) ──
          if (_showDropdown && _results.isNotEmpty)
            Container(
              constraints: const BoxConstraints(maxHeight: 240),
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: AppTheme.backgroundSecondary.withValues(alpha: 0.97),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.border),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x60000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: _results.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, color: AppTheme.border),
                  itemBuilder: (context, index) {
                    final airport = _results[index];
                    return ListTile(
                      dense: true,
                      title: Text(
                        airport.icao,
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        airport.name,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(
                        Icons.local_airport,
                        color: AppTheme.textTertiary,
                        size: 16,
                      ),
                      onTap: () => _onSelected(airport),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
