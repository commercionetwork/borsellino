import 'dart:convert';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/validators/validator_filter.dart';
import 'package:borsellino/source/apis/apis.dart';
import 'package:borsellino/source/validators/validator_converter.dart';
import 'package:borsellino/source/validators/validator_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// Source that should be used when retrieving data related to
/// validators.
class ValidatorSource {
  final ApiEndpoints endpoints;
  final http.Client httpClient;

  final ValidatorConverter converter;

  ValidatorSource({
    @required this.endpoints,
    @required this.httpClient,
    @required this.converter,
  }) : assert(endpoints != null && httpClient != null && converter != null);

  Future<List<Validator>> getValidators(ValidatorFilter filter) async {
    var apiUrl = "${endpoints.validatorsList}";

    // Update the URL including the status
    switch (filter.status) {
      case ValidatorStatus.ACTIVE:
        apiUrl += "?status=bonded";
        break;
      case ValidatorStatus.INACTIVE:
        apiUrl += "?status=unbonded";
        break;
      default:
        // Nothing to do, get all the validators
        break;
    }

    final response = await httpClient.get(apiUrl);
    return checkValidatorsResponse(response);
  }

  List<Validator> checkValidatorsResponse(http.Response response) {
    if (response.statusCode == 200) {
      // If the server returns OK, parse the JSON
      final validatorsList = json.decode(response.body) as List;
      print("Received validators $json");

      // Get the JSON objects
      final validatorJsons = validatorsList
          .map((object) => ValidatorJson.fromMap(object))
          .toList();

      // Get the real Validator entities
      return converter.convert(validatorJsons);
    } else {
      // If the response was not OK, throw an error
      throw Exception("Failed to load validators list");
    }
  }
}
