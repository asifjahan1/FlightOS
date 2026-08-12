import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('assets/data/airports_seed.json');
  final jsonList = jsonDecode(file.readAsStringSync()) as List<dynamic>;
  
  int count = 0;
  for (final item in jsonList) {
    if (item['type'] == 'large_airport') {
      final lat = item['latitude'] as double;
      final lon = item['longitude'] as double;
      if (lat >= 24.0 && lat <= 50.0 && lon >= -125.0 && lon <= -66.0) {
        count++;
      }
    }
  }
  print('Large airports in US bounds: $count');
}
