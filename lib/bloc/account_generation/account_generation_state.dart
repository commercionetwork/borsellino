import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AccountGenerationState extends Equatable {
  AccountGenerationState([List props = const []]) : super(props);
}

class InitialAccountGenerationState extends AccountGenerationState {}

class GeneratingAccountState extends AccountGenerationState {}

class GeneratedAccountState extends AccountGenerationState {}

class ErrorGeneratingAccountState extends AccountGenerationState {
  final String message;

  ErrorGeneratingAccountState(this.message) : super([message]);
}
