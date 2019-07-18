import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ImportMnemonicEvent extends Equatable {
  ImportMnemonicEvent([List props = const []]) : super(props);
}

class ClearMnemonicEvent extends ImportMnemonicEvent {}

class CurrentMnemonicChangedEvent extends ImportMnemonicEvent {
  final String mnemonic;

  CurrentMnemonicChangedEvent(this.mnemonic);
}
