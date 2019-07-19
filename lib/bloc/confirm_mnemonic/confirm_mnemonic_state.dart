import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfirmMnemonicState extends Equatable {
  ConfirmMnemonicState([List props = const []]) : super(props);
}

class InitialMnemonicConfirmationState extends ConfirmMnemonicState {}

class GeneratingVerificationWordsState extends ConfirmMnemonicState {}

class VerificationWordsGeneratedState extends ConfirmMnemonicState {
  final Map<int, String> words;

  VerificationWordsGeneratedState(this.words) : super([words]);
}

class VerificationWordsInvalidState extends VerificationWordsGeneratedState {
  VerificationWordsInvalidState(Map<int, String> words) : super(words);
}

class VerificationWordsValidState extends VerificationWordsGeneratedState {
  VerificationWordsValidState(Map<int, String> words) : super(words);
}
