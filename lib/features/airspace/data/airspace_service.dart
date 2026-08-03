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

      _cachedAirspaces = jsonList.map((json) {
        final List<dynamic> rawBoundary = json['boundary'];
        final boundary = rawBoundary.map((dynamic c) {
          final coord = c as List<dynamic>;
          return [(coord[0] as num).toDouble(), (coord[1] as num).toDouble()];
        }).toList();

        return Airspace(
          id: json['id'],
          name: json['name'],
          type: json['type'],
          floorAltitude: json['floor'] as int,
          ceilingAltitude: json['ceiling'] as int,
          boundary: boundary,
        );
      }).toList();

      return _cachedAirspaces!;
    } catch (e) {
      return [];
    }
  }
}
