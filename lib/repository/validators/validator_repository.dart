import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/validators/validator_filter.dart';
import 'package:borsellino/source/sources.dart';

/// Class representing the repository that should be contact when dealing
/// with validators.
class ValidatorsRepository {
  final ValidatorSource validatorsSource;

  ValidatorsRepository(
    this.validatorsSource,
  ) : assert(validatorsSource != null);

  /// Allows to retrieve the list of all validators satisfying the given filter.
  Future<List<Validator>> getValidators(ValidatorFilter filter) async {
    return await validatorsSource.getValidators(filter);
  }

  Future<String> getValidatorImageUrl(Validator validator) async {
    return await validatorsSource.getValidatorImageUrl(validator);
  }
}
