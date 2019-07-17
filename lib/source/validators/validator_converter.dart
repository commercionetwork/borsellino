import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/validators/validator_json.dart';
import 'package:flutter/services.dart';

/// Allows to convert a JSON object into a list of validators.
class ValidatorConverter {
  /// Convert the given list of ValidatorJson to a list of Validator
  List<Validator> convert(List<ValidatorJson> validators) {
    // Sum up all the tokens that are distributed
    final totalTokens = validators.fold(0, (total, validator) {
      return total + validator.tokens;
    });

    // Convert each validator using the computed total tokens
    return validators
        .map((validator) => _convertValidator(validator, totalTokens))
        .toList();
  }

  Validator _convertValidator(ValidatorJson validator, double totalTokens) {
    ValidatorStatus status;

    switch (validator.status) {
      case 0:
        status = ValidatorStatus.INACTIVE;
        break;
      case 1:
        status = ValidatorStatus.ACTIVE;
        break;
      default:
        status = ValidatorStatus.UNKNOWN;
        break;
    }

    return Validator(
        status: status,
        name: validator.name,
        identity: validator.identity,
        address: validator.address,
        tokens: validator.tokens,
        commissionRate: validator.commissionRate,
        yieldPercentage: validator.tokens / totalTokens * 100);
  }
}
