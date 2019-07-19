import 'dart:convert';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/validators/validator_filter.dart';
import 'package:borsellino/source/sources.dart';
import 'package:borsellino/source/utils.dart';
import 'package:borsellino/source/validators/validator_converter.dart';
import 'package:borsellino/source/validators/validator_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// Source that should be used when retrieving data related to
/// validators.
class ValidatorSource {
  // Endpoints
  static const _validatorsEndpoint = "staking/validators";

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

  Future<ChainInfo> _getChainInfo() async {
    final account = await accountsSource.getCurrentAccount();
    if (account == null) {
      throw Exception("Null account");
    }
    return account.chain;
  }

  Future<List<Validator>> getValidators(ValidatorFilter filter) async {
    // Get the chain info
    final chain = await _getChainInfo();

    // Get the API url based on the account chain
    var apiUrl = "${chain.lcdUrl}/$_validatorsEndpoint";
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

  Future<String> getValidatorImageUrl(Validator validator) async {
    // Get the chain info
    final chain = await _getChainInfo();

    // Get the details URL
    final detailsApi =
        "${chain.lcdUrl}/$_validatorsEndpoint/${validator.address}";

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

    // TODO: Save as constant somewhere
    final keyApi =
        "https://keybase.io/_/api/1.0/key/fetch.json?pgp_key_ids=$identity";
    final keyBaseResponse = await httpClient.get(keyApi);
    checkResponse(keyBaseResponse);

    // Get the key fingerprint
    final keysData = json.decode(keyBaseResponse.body) as Map<String, dynamic>;
    final key = (keysData["keys"] as List)[0] as Map<String, dynamic>;
    final keyFingerprint = key["key_fingerprint"];

    // TODO: Save as constant
    final iconApi =
        "https://keybase.io/_/api/1.0/user/lookup.json?key_fingerprint=$keyFingerprint&fields=pictures";
    final iconResponse = await httpClient.get(iconApi);
    checkResponse(iconResponse);

    // Parse the data
    final data = json.decode(iconResponse.body) as Map<String, dynamic>;
    final them = data["them"][0];
    final picture = them["pictures"]["primary"]["url"];

    return picture;
  }
}
