import 'package:borsellino/source/apis/apis.dart';
import 'package:dependencies/dependencies.dart';
import 'package:http/http.dart' as http;

/// Implementation of Module that allows to provide all the dependencies
/// needed when working with REST APIs
class ApisModule implements Module {

  @override
  void configure(Binder binder) {
    binder
      ..bindLazySingleton((i, p) => http.Client())
      ..bindLazySingleton((i, p) => buildApisEndpoints());
  }

  // TODO: Edit there all the endpoints that can be used inside the application
  ApiEndpoints buildApisEndpoints() {

    // TODO: Edit the base URL
    final _apisBaseUrl = "https://lcd.n01c01p1f2.commercio.network";

    return ApiEndpoints(
      validatorsList: "$_apisBaseUrl/staking/validators",
    );
  }
}
