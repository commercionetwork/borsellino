import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfirmMnemonicEvent extends Equatable {
  ConfirmMnemonicEvent([List props = const []]) : super(props);
}

class GetRandomVerificationWordsEvent extends ConfirmMnemonicEvent {
  final List<String> mnemonic;
  GetRandomVerificationWordsEvent(this.mnemonic) : super([mnemonic]);
}

class VerifyInsertedWordsEvent extends ConfirmMnemonicEvent {
  final Map<int, String> insertedWords;
  final Map<int, String> originalWords;

  VerifyInsertedWordsEvent({this.insertedWords, this.originalWords});
}
