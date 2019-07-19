import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AccountSelectionEvent extends Equatable {
  AccountSelectionEvent([List props = const []]) : super(props);
}

class LoadAccountsEvent extends AccountSelectionEvent {}
