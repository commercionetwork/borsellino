import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/sources.dart';
import 'package:meta/meta.dart';

/// Class representing the repository that should be contact when dealing
/// with validators.
class ValidatorsRepository {
  final ValidatorSource source;

  ValidatorsRepository({@required this.source}) : assert(source != null);

  /// Allows to retrieve the list of all validators.
  Future<List<Validator>> getValidatorsList() async {
    return await source.getValidators();
  }
}
