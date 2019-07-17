import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/validators/validator_filter.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ValidatorsEvent extends Equatable {
  ValidatorsEvent([List props = const []]) : super(props);
}


/// Represents the event that must be emitted when wanting to load
/// a list of validators satisfying a given filter.
class LoadValidatorsEvent extends ValidatorsEvent {
  final ValidatorFilter filter;

  LoadValidatorsEvent(this.filter);
}
