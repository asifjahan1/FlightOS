import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:skynav/features/airspace/domain/entities/airspace.dart';

@lazySingleton
class AirspaceService {
  List<Airspace>? _cachedAirspaces;

  Future<List<Airspace>> getAirspaces() async {
    if (_cachedAirspaces != null) {
      return _cachedAirspaces!;
    }

    try {
      final jsonString = await rootBundle.loadString('assets/data/airspaces_seed.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      _cachedAirspaces = jsonList.map((dynamic item) {
        final jsonMap = item as Map<String, dynamic>;
        final List<dynamic> rawBoundary = jsonMap['boundary'];
        final boundary = rawBoundary.map((dynamic c) {
          final coord = c as List<dynamic>;
          return [(coord[0] as num).toDouble(), (coord[1] as num).toDouble()];
        }).toList();

        return Airspace(
          id: jsonMap['id'] as String,
          name: jsonMap['name'] as String,
          type: jsonMap['type'] as String,
          floorAltitude: jsonMap['floor'] as int,
          ceilingAltitude: jsonMap['ceiling'] as int,
          boundary: boundary,
        );
      }).toList();

      return _cachedAirspaces!;
    } catch (e) {
      return [];
    }
  }
}
