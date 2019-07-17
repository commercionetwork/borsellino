import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

/// Represents the data contained inside a single object retrieved
/// from the list of validators.
class ValidatorJson {
  final int status;
  final String name;
  final String address;
  final double tokens;
  final String identity;
  final String website;
  final double commissionRate;

  ValidatorJson({
    @required this.status,
    @required this.name,
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
      address: json["operator_address"],
      tokens: double.parse(json["tokens"]) * 0.0000001,
      identity: json["description"]["identity"],
      website: json["description"]["website"],
      commissionRate: double.parse(json["commission"]["rate"]),
    );
  }
}
