import 'dart:convert';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/validators/validator_filter.dart';
import 'package:borsellino/source/sources.dart';
import 'package:borsellino/source/utils.dart';
import 'package:borsellino/source/validators/apis.dart';
import 'package:borsellino/source/validators/validator_converter.dart';
import 'package:borsellino/source/validators/validator_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:sprintf/sprintf.dart';

/// Source that should be used when retrieving data related to
/// validators.
class ValidatorSource {
  final AccountsSource accountsSource;
  final http.Client httpClient;

  final ValidatorConverter converter;

  ValidatorSource({
    @required this.accountsSource,
    @required this.httpClient,
    @required this.converter,
  })  : assert(accountsSource != null),
        assert(httpClient != null),
        assert(converter != null);

  /// Returns the chain information for the currently selected account.
  Future<ChainInfo> _getChainInfo() async {
    final account = await accountsSource.getCurrentAccount();
    if (account == null) {
      throw Exception("Null account");
    }
    return account.chain;
  }

  /// Returns the list of all the validators satisfying the given [filter].
  Future<List<Validator>> getValidators(ValidatorFilter filter) async {
    // Get the chain info
    final chain = await _getChainInfo();

    // Get the API url based on the account chain
    var apiUrl = sprintf(ValidatorsEndpoints.LIST, [chain.lcdUrl]);
    print("Getting validators from: $apiUrl");

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
    return _checkValidatorsResponse(response);
  }

  /// Makes sure the given [response] contains a valid list of validators
  /// and returns that list.
  List<Validator> _checkValidatorsResponse(http.Response response) {
    // Check the response
    checkResponse(response);

    // If the server returns OK, parse the JSON
    final validatorsList = json.decode(response.body) as List;

    // Get the JSON objects
    final validatorJsons =
        validatorsList.map((object) => ValidatorJson.fromMap(object)).toList();

    // Get the real Validator entities
    return converter.convert(validatorJsons);
  }

  /// Returns the [String] representing the URL of the icon
  /// of the given [validator], or `null` if nothing can be found.
  Future<String> getValidatorImageUrl(Validator validator) async {
    // Get the chain info
    final chain = await _getChainInfo();

    // Get the details URL
    final detailsApi = sprintf(
      ValidatorsEndpoints.DETAILS,
      [chain.lcdUrl, validator.address],
    );

    // Get the details of the validator
    final response = await httpClient.get(detailsApi);
    checkResponse(response);

    // Extract the identity data
    final validatorInfo = json.decode(response.body) as Map<String, dynamic>;
    final identity = validatorInfo["description"]["identity"] as String;

    // If the identity is empty return null
    if (identity.isEmpty) {
      return null;
    }

    // Get the autocompletion API response
    final keyApi = sprintf(ValidatorsEndpoints.ICON, [identity]);
    final keyBaseResponse = await httpClient.get(keyApi);
    checkResponse(keyBaseResponse);

    // Parse the data
    final data = json.decode(keyBaseResponse.body) as Map<String, dynamic>;
    final completions = data["completions"] as List;
    if (completions.isEmpty) {
      return null;
    }

    // Get the thumbnail
    final completionData = completions[0] as Map<String, dynamic>;
    return completionData["thumbnail"];
  }
}
