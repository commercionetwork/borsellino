import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChainSelectionEvent extends Equatable {
  ChainSelectionEvent([List props = const []]) : super(props);
}

class LoadChainsEvent extends ChainSelectionEvent {}
