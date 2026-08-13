library;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:skynav/core/constants/api_constants.dart';

class OverpassApiClient {
  /// Fetches facilities (food, fuel, amenities) near an airport's coordinates.
  /// Bounding box is typically small around the airport (e.g. 2000 meters).
  Future<List<String>> fetchAirportFacilities(double lat, double lon) async {
    try {
      // Query amenities like restaurants, cafes, fuel within 2000m radius of the airport center
      const query = r'''
      [out:json][timeout:10];
      (
        node["amenity"~"restaurant|cafe|fast_food|fuel|car_rental"](around:2000,$lat,$lon);
        way["amenity"~"restaurant|cafe|fast_food|fuel|car_rental"](around:2000,$lat,$lon);
      );
      out tags;
      ''';

      final url = Uri.parse(ApiConstants.overpassApiEndpoint);
      final response = await http
          .post(
            url,
            body: query,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // ignore: avoid_dynamic_calls
        final elements = data['elements'] as List<dynamic>?;
        if (elements == null) return [];

        final facilities = <String>{};
        for (final el in elements) {
          final tags = el['tags'] as Map<String, dynamic>?;
          if (tags != null) {
            final amenity = tags['amenity']?.toString();
            final name = tags['name']?.toString();
            if (amenity != null) {
              final formattedAmenity = amenity
                  .replaceAll('_', ' ')
                  .toUpperCase();
              facilities.add(
                name != null ? r'$name ($formattedAmenity)' : formattedAmenity,
              );
            }
          }
        }
        return facilities.toList();
      }
      return [];
    } catch (e) {
      if (kDebugMode) {
        print(r'Failed to fetch facilities from Overpass: $e');
      }
      return [];
    }
  }
}
