import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WalletOverviewEvent extends Equatable {
  WalletOverviewEvent([List props = const []]) : super(props);
}

class LoadWalletDataEvent extends WalletOverviewEvent {}
