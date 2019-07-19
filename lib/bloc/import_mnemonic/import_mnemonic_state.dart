import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ImportMnemonicState extends Equatable {
  final List<String> mnemonic;
  ImportMnemonicState(this.mnemonic, [List props = const []]) : super(props + [mnemonic]);
}

class EmptyMnemonicState extends ImportMnemonicState {
  EmptyMnemonicState() : super(List());
}

class ValidMnemonicLengthState extends ImportMnemonicState {
  final List<String> mnemonic;

  ValidMnemonicLengthState(this.mnemonic) : super(mnemonic);
}

class InvalidMnemonicLengthState extends ImportMnemonicState {
  final List<String> mnemonic;

  InvalidMnemonicLengthState(this.mnemonic) : super(mnemonic);
}
