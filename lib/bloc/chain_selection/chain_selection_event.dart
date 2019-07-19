import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChainSelectionEvent extends Equatable {
  ChainSelectionEvent([List props = const []]) : super(props);
}

/// Event that is emitted when the chains needs to be loaded.
class LoadChainsEvent extends ChainSelectionEvent {}