import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';

void main() {
  if (kDebugMode) {
    print(const CsvDecoder().convert('a,b\n1,2'));
  }
}
