import 'package:borsellino/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChainSelectionState extends Equatable {
  ChainSelectionState([List props = const []]) : super(props);
}

/// State that is set when the chain selection
/// page is shown for the first time
class InitialChainSelectionState extends ChainSelectionState {}

/// State that is set when the chains are being loaded
class LoadingChainsState extends ChainSelectionState {}

/// State that is set when the chains have all being loaded
/// and are ready to be displayed
class LoadedChainsState extends ChainSelectionState {
  final List<ChainInfo> chains;
  LoadedChainsState(this.chains) : super([chains]);
}

/// State that is set when there has been an error while
/// loading the chains
class ErrorChainsState extends ChainSelectionState {}
