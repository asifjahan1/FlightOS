import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:skynav/features/telemetry/domain/entities/fleet_target.dart';
import 'package:skynav/features/telemetry/domain/entities/telemetry_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton
class FleetTrackingService {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  /// Upserts the user's current location to the `fleet_locations` table.
  Future<void> broadcastLocation(TelemetryData data) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    try {
      await _supabase.from('fleet_locations').upsert({
        'id': userId,
        'latitude': data.latitude,
        'longitude': data.longitude,
        'altitude': data.altitudeMslFeet,
        'heading': data.trueTrack,
        'speed': data.groundSpeedKnots,
        'dest_lat': data.destinationLatitude,
        'dest_lng': data.destinationLongitude,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      });
    } catch (e) {
      // Ignore broadcast errors so it doesn't crash the UI if offline
    }
  }

  /// Streams the locations of all other fleet targets.
  /// If the current user is not the admin, this stream will yield empty lists due to RLS.
  Stream<List<FleetTarget>> getFleetStream() {
    return _supabase
        .from('fleet_locations')
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> data) {
          final currentUserId = _supabase.auth.currentUser?.id;
          
          return data
              .where((row) => row['id'] != currentUserId) // Filter out ownship
              .map(FleetTarget.fromJson)
              .toList();
        });
  }
}
