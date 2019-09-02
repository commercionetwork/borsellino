import 'package:borsellino/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WalletOverviewState extends Equatable {
  WalletOverviewState([List props = const []]) : super(props);
}

class InitialWalletOverviewState extends WalletOverviewState {}

class LoadingWalletDataState extends WalletOverviewState {}

class WalletDataLoadedState extends WalletOverviewState {
  final Account wallet;

  WalletDataLoadedState(this.wallet) : super([wallet]);
}

class WalletErrorState extends WalletOverviewState{}
