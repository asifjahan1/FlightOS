import 'package:csv/csv.dart';

void main() {
  print(const CsvDecoder().convert('a,b\n1,2'));
}
