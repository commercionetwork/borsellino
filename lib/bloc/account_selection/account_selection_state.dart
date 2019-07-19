import 'package:borsellino/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AccountSelectionState extends Equatable {
  AccountSelectionState([List props = const []]) : super(props);
}

class InitialAccountSelectionState extends AccountSelectionState {}

class LoadingAccountsState extends AccountSelectionState {}

class AccountsLoadedState extends AccountSelectionState {
  final List<Account> accounts;
  AccountsLoadedState(this.accounts) : super([accounts]);
}

class ErrorAccountsState extends AccountSelectionState {}
