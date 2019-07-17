import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/sources.dart';

/// Class representing the repository that should be contact when dealing
/// with validators.
class ValidatorsRepository {
  final ValidatorSource source;

  ValidatorsRepository({this.source});

  /// Allows to retrieve the list of all validators.
  Future<List<Validator>> getValidatorsList() async {
    return await source.getValidators();
  }

}