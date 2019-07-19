import 'package:dependencies/dependencies.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UtilsModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindLazySingleton((i, p) => http.Client())
      ..bindLazySingleton((injector, p) => FlutterSecureStorage());
  }
}