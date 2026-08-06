library;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// import 'package:skynav/core/constants/api_constants.dart';

class AviationWeatherApi {
  /// Fetches the latest METAR for a given ICAO code.
  Future<String?> fetchMetar(String icao) async {
    try {
      final url = Uri.parse(
        r'${ApiConstants.aviationWeatherApiEndpoint}/metar?ids=$icao&format=json',
      );
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        if (data.isNotEmpty) {
          // ignore: avoid_dynamic_calls
          return data[0]['rawOb'] as String?;
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(r'Failed to fetch METAR: $e');
      }
      return null;
    }
  }

  /// Fetches the latest TAF for a given ICAO code.
  Future<String?> fetchTaf(String icao) async {
    try {
      final url = Uri.parse(
        r'${ApiConstants.aviationWeatherApiEndpoint}/taf?ids=$icao&format=json',
      );
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        if (data.isNotEmpty) {
          // ignore: avoid_dynamic_calls
          return data[0]['rawTAF'] as String?;
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(r'Failed to fetch TAF: $e');
      }
      return null;
    }
  }
}
