import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ValidatorsEvent extends Equatable {
  ValidatorsEvent([List props = const []]) : super(props);
}

class LoadValidatorsEvent extends ValidatorsEvent {}
