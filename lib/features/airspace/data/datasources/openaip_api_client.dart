import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:skynav/core/constants/api_constants.dart';

@lazySingleton
class OpenAipApiClient {
  OpenAipApiClient();

  /// Track whether we've already warned about auth failure to avoid log spam.
  bool _authFailureLogged = false;

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
      if (kDebugMode && !_authFailureLogged) {
        debugPrint('[OpenAIP] API Key is missing. Add OPENAIP_CLIENT_ID to .env');
        _authFailureLogged = true;
      }
      return [];
    }

    try {
      // Send key as both header and query param (docs support both methods)
      final uri = Uri.parse(
        '${ApiConstants.openAipApiEndpoint}/airspaces'
        '?bbox=$lonMin,$latMin,$lonMax,$latMax'
        '&apiKey=$apiKey',
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
      } else if (response.statusCode == 403 || response.statusCode == 401) {
        // Auth failure — log once, don't spam on every map move
        if (!_authFailureLogged) {
          debugPrint(
            '[OpenAIP] Authentication failed (${response.statusCode}). '
            'Your API key may be expired. Generate a new one at openaip.net.',
          );
          _authFailureLogged = true;
        }
        return [];
      } else {
        if (kDebugMode) {
          debugPrint('[OpenAIP] API Error: ${response.statusCode}');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[OpenAIP] Network error: $e');
      }
      return [];
    }
  }
}

