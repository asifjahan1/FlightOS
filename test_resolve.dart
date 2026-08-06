import 'dart:isolate';

void main() async {
  final uri = await Isolate.resolvePackageUri(Uri.parse('package:csv/csv.dart'));
  print(uri);
}
