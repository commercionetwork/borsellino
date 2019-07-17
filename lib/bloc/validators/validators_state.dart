import 'package:borsellino/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ValidatorsState extends Equatable {
  ValidatorsState([List props = const []]) : super(props);
}

class EmptyValidatorsState extends ValidatorsState {}

class LoadingValidatorsState extends ValidatorsState {}

class ValidatorsLoadedState extends ValidatorsState {
  final List<Validator> validators;

  ValidatorsLoadedState({@required this.validators})
      : assert(validators != null),
        super(validators);
}

class ValidatorsErrorState extends ValidatorsState {}