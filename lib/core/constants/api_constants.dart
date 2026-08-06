library;

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Constants for all external APIs used in SkyNavi.
/// The client will provide the actual paid API keys later. 
/// For now, these are configured with placeholders or free tiers.
class ApiConstants {
  // Flight Tracker (OpenSky Network)
  // For OpenSky, anonymous access is allowed but rate-limited.
  // Add auth here when credentials are provided.
  static const String openSkyApiEndpoint = 'https://opensky-network.org/api';
  static String get openSkyUsername => dotenv.env['OPENSKY_USERNAME'] ?? ''; 
  static String get openSkyPassword => dotenv.env['OPENSKY_PASSWORD'] ?? '';

  // Aviation Weather (AviationWeather.gov)
  // This is a free US government API that requires no key.
  static const String aviationWeatherApiEndpoint = 'https://aviationweather.gov/api/data';

  // OpenStreetMap Overpass API for detailed airport facilities (Food, Fuel, etc)
  static const String overpassApiEndpoint = 'https://overpass-api.de/api/interpreter';
  
  // Future MapLibre or Mapbox API key if required
  static String get mapboxApiKey => dotenv.env['MAPBOX_API_KEY'] ?? '';

  // OpenAIP API (Aviation Data & Airspaces)
  static const String openAipApiEndpoint = 'https://api.core.openaip.net/api';
  static String get openAipApiKey => dotenv.env['OPENAIP_CLIENT_ID'] ?? '';
}
