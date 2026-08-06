import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:skynav/core/constants/api_constants.dart';

@lazySingleton
class OpenAipApiClient {
  OpenAipApiClient();

  /// Fetches airspaces within a bounding box.
  /// Bounding box format usually expects lonMin,latMin,lonMax,latMax.
  Future<List<dynamic>> fetchAirspaces({
    required double latMin,
    required double lonMin,
    required double latMax,
    required double lonMax,
  }) async {
    final apiKey = ApiConstants.openAipApiKey;
    if (apiKey.isEmpty) {
      if (kDebugMode) {
        print('OpenAIP API Key is missing. Please add it to .env');
      }
      return [];
    }

    try {
      // bbox is typically lonMin,latMin,lonMax,latMax
      final uri = Uri.parse(
        '${ApiConstants.openAipApiEndpoint}/airspaces?bbox=$lonMin,$latMin,$lonMax,$latMax',
      );

      final response = await http.get(
        uri,
        headers: {'x-openaip-client-id': apiKey, 'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // The API returns an object with an 'items' array
        // ignore: avoid_dynamic_calls
        final items = data['items'] as List<dynamic>?;
        return items ?? [];
      } else {
        throw Exception(
          'OpenAIP API Error: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch airspaces from OpenAIP: $e');
      }
      return [];
    }
  }
}
