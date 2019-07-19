import 'package:borsellino/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AccountGenerationState extends Equatable {
  AccountGenerationState([List props = const []]) : super(props);
}

class InitialAccountGenerationState extends AccountGenerationState {}

class GeneratingAccountState extends AccountGenerationState {
  final ChainInfo chain;
  GeneratingAccountState({this.chain}) : super([chain]);
}

class AccountGeneratedState extends AccountGenerationState {
  final Account account;
  AccountGeneratedState(this.account);
}

class ErrorGeneratingAccountState extends AccountGenerationState {}
