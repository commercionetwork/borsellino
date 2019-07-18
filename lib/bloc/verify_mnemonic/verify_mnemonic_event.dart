import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VerifyMnemonicEvent extends Equatable {
  VerifyMnemonicEvent([List props = const []]) : super(props);
}

class GetRandomVerificationWordsEvent extends VerifyMnemonicEvent {
  final List<String> mnemonic;
  GetRandomVerificationWordsEvent(this.mnemonic) : super([mnemonic]);
}

class VerifyInsertedWordsEvent extends VerifyMnemonicEvent {
  final Map<int, String> insertedWords;
  final Map<int, String> originalWords;

  VerifyInsertedWordsEvent({this.insertedWords, this.originalWords});
}
