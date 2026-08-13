library;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:skynav/core/constants/api_constants.dart';
import 'package:skynav/features/traffic/domain/models/aircraft_state.dart';

/// Client to communicate with the OpenSky Network API.
class OpenSkyApiClient {
  /// Fetches live traffic within a specific geographic bounding box.
  /// Bounding box is specified by: [lamin, lomin, lamax, lomax].
  Future<List<AircraftState>> fetchTrafficInBounds({
    required double latMin,
    required double latMax,
    required double lonMin,
    required double lonMax,
  }) async {
    try {
      final uri = Uri.parse(
        '${ApiConstants.openSkyApiEndpoint}/states/all?lamin=$latMin&lomin=$lonMin&lamax=$latMax&lomax=$lonMax',
      );

      // Using anonymous access for now as per requirements.
      // Can add Basic Auth header using ApiConstants.openSkyUsername later.
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // ignore: avoid_dynamic_calls
        final states = data['states'] as List<dynamic>?;

        if (states == null) return [];

        return states
            .map(
              (stateVector) =>
                  AircraftState.fromOpenSky(stateVector as List<dynamic>),
            )
            .where(
              (aircraft) =>
                  aircraft.latitude != 0.0 && aircraft.longitude != 0.0,
            )
            .toList();
      } else {
        throw Exception('OpenSky API Error: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to fetch traffic from OpenSky: $e');
      }
      return [];
    }
  }
}
