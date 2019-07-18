import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GenerateMnemonicState extends Equatable {
  GenerateMnemonicState([List props = const []]) : super(props);
}

class InitialGenerateMnemonicState extends GenerateMnemonicState{}

class GeneratingMnemonicState extends GenerateMnemonicState {}

class MnemonicGeneratedState extends GenerateMnemonicState {
  final List<String> mnemonic;
  MnemonicGeneratedState(this.mnemonic) : super([mnemonic]);
}
