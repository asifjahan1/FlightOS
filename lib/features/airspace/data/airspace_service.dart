import 'package:injectable/injectable.dart';
import 'package:skynav/features/airspace/data/datasources/openaip_api_client.dart';
import 'package:skynav/features/airspace/domain/entities/airspace.dart';

@lazySingleton
class AirspaceService {
  AirspaceService(this._apiClient);
  
  final OpenAipApiClient _apiClient;

  // We can still cache if we want, but for live API it might be better 
  // to clear cache on move or keep a set of fetched airspaces. 
  // For simplicity, we'll keep a cached map by ID.
  final Map<String, Airspace> _cachedAirspaces = {};

  Future<List<Airspace>> getAirspaces({
    required double latMin,
    required double lonMin,
    required double latMax,
    required double lonMax,
  }) async {
    try {
      final jsonList = await _apiClient.fetchAirspaces(
        latMin: latMin,
        lonMin: lonMin,
        latMax: latMax,
        lonMax: lonMax,
      );

      final newAirspaces = jsonList.map((dynamic item) {
        final jsonMap = item as Map<String, dynamic>;
        
        // OpenAIP Geometry is GeoJSON-like
        // Extracting Polygon coordinates (first ring)
        final geometry = jsonMap['geometry'] as Map<String, dynamic>?;
        List<List<double>> boundary = [];
        
        if (geometry != null && geometry['type'] == 'Polygon') {
          final coordinates = geometry['coordinates'] as List<dynamic>?;
          if (coordinates != null && coordinates.isNotEmpty) {
            final ring = coordinates[0] as List<dynamic>;
            boundary = ring.map((dynamic c) {
              final coord = c as List<dynamic>;
              // GeoJSON is [lon, lat], our app expects [lat, lon]
              return [(coord[1] as num).toDouble(), (coord[0] as num).toDouble()];
            }).toList();
          }
        }

        // OpenAIP uses objects for limits
        final lowerLimit = jsonMap['lowerLimit'] as Map<String, dynamic>?;
        final upperLimit = jsonMap['upperLimit'] as Map<String, dynamic>?;
        
        // OpenAIP type is an integer, we'll map it loosely or just toString
        final typeInt = jsonMap['type'];
        final typeStr = 'Type $typeInt';

        final id = jsonMap['_id'] as String? ?? jsonMap['id']?.toString() ?? '';
        
        return Airspace(
          id: id,
          name: jsonMap['name'] as String? ?? 'Unknown Airspace',
          type: typeStr,
          floorAltitude: (lowerLimit?['value'] as num?)?.toInt() ?? 0,
          ceilingAltitude: (upperLimit?['value'] as num?)?.toInt() ?? 60000,
          boundary: boundary,
        );
      }).where((a) => a.boundary.isNotEmpty && a.id.isNotEmpty).toList();

      for (final a in newAirspaces) {
        _cachedAirspaces[a.id] = a;
      }

      return _cachedAirspaces.values.toList();
    } catch (e) {
      return _cachedAirspaces.values.toList();
    }
  }
}
