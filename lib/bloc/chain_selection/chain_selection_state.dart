import 'package:borsellino/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChainSelectionState extends Equatable {
  ChainSelectionState([List props = const []]) : super(props);
}

class InitialChainSelectionState extends ChainSelectionState {}

class LoadingChainsState extends ChainSelectionState {}

class LoadedChainsState extends ChainSelectionState {
  final List<ChainInfo> chains;
  LoadedChainsState(this.chains) : super([chains]);
}

class ErrorChainsState extends ChainSelectionState {}
