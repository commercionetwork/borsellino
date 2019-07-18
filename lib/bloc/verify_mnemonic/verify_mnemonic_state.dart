import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VerifyMnemonicState extends Equatable {
  VerifyMnemonicState([List props = const []]) : super(props);
}

class InitialVerifyMnemonicState extends VerifyMnemonicState {}

class GeneratingVerificationWordsState extends VerifyMnemonicState {}

class VerificationWordsGeneratedState extends VerifyMnemonicState {
  final Map<int, String> words;

  VerificationWordsGeneratedState(this.words) : super([words]);
}

class VerificationWordsInvalidState extends VerificationWordsGeneratedState {
  VerificationWordsInvalidState(Map<int, String> words) : super(words);
}

class VerificationWordsValidState extends VerificationWordsGeneratedState {
  VerificationWordsValidState(Map<int, String> words) : super(words);
}
