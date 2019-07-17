import 'dart:convert';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/apis/apis.dart';
import 'package:http/http.dart' as http;

/// Source that should be used when retrieving data related to
/// validators.
class ValidatorSource {
  final ApiEndpoints endpoints;
  final http.Client httpClient;

  ValidatorSource({this.endpoints, this.httpClient});

  Future<List<Validator>> getValidators() async {
    final apiUrl = "${endpoints.validatorsList}?status=bonded";
    final response = await httpClient.get(apiUrl);

    if (response.statusCode == 200) {
      // If the server returns OK, parse the JSON
      return ValidatorConverter.getValidatorsList(json.decode(response.body));

    } else {
      // If the response was not OK, throw an error
      throw Exception("Failed to load validators list");
    }
  }
}


/// Allows to convert a JSON object into a list of validators.
class ValidatorConverter {
  static List<Validator> getValidatorsList(List<dynamic> json) {
    print("Received validators $json");

    return json
        .map((validator) => _convertValidator(validator))
        .toList();
  }

  static Validator _convertValidator(Map<String, dynamic> json) {
    return Validator(
      name: json["description"]["moniker"],
      address: json["operator_address"],
      tokens: json["tokens"],
      commission: json["commission"]["rate"],
    );
  }
}
