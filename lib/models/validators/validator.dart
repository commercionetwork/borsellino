import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

/// Contains the data relative to a single validator.
class Validator {
  final ValidatorStatus status;
  final String name;
  final String address;
  final String identity;
  final String website;
  final String description;
  final double tokens;
  final double commissionRate;
  final double yieldPercentage;

  Validator({
    @required this.status,
    @required this.identity,
    @required this.name,
    @required this.description,
    @required this.website,
    @required this.address,
    @required this.tokens,
    @required this.commissionRate,
    @required this.yieldPercentage,
  }) : assert(status != null &&
            name != null &&
            address != null &&
            tokens != null &&
            commissionRate != null &&
            yieldPercentage != null);
}

enum ValidatorStatus { ACTIVE, INACTIVE, UNKNOWN }
