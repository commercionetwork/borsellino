import 'package:borsellino/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

/// Represents the data contained inside a single object retrieved
/// from the list of validators.
class ValidatorJson {
  final int status;
  final String name;
  final String address;
  final String identity;
  final String website;
  final String description;
  final double tokens;
  final double commissionRate;

  ValidatorJson({
    @required this.status,
    @required this.name,
    @required this.description,
    @required this.address,
    @required this.tokens,
    @required this.identity,
    @required this.website,
    @required this.commissionRate,
  });

  factory ValidatorJson.fromMap(Map<String, dynamic> json) {
    return ValidatorJson(
      status: json["status"],
      name: json["description"]["moniker"],
      description: json["description"]["details"],
      address: json["operator_address"],
      tokens: double.parse(json["tokens"]) * TOKEN_MULTIPLICATION_FACTOR,
      identity: json["description"]["identity"],
      website: json["description"]["website"],
      commissionRate: double.parse(json["commission"]["rate"]),
    );
  }
}
