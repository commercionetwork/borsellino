import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:borsellino/bloc/verify_mnemonic/verify_mnemonic_event.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/repository/repositories.dart';
import './bloc.dart';

class VerifyMnemonicBloc
    extends Bloc<VerifyMnemonicEvent, VerifyMnemonicState> {
  final MnemonicRepository mnemonicRepository = BorsellinoInjector.get();

  @override
  VerifyMnemonicState get initialState => InitialVerifyMnemonicState();

  @override
  Stream<VerifyMnemonicState> mapEventToState(
    VerifyMnemonicEvent event,
  ) async* {
    // We need to get a new list of words
    if (event is GetRandomVerificationWordsEvent) {
      // Immediately tell the generation is in progress
      yield GeneratingVerificationWordsState();

      // Get the words from the repository
      final words =
          await mnemonicRepository.getVerificationWords(event.mnemonic);

      // Return the new state
      yield VerificationWordsGeneratedState(words);
    }

    // We need to verify the words
    if (event is VerifyInsertedWordsEvent) {
      final areWordsValid = await mnemonicRepository.verifyInsertedWords(
        event.originalWords,
        event.insertedWords,
      );

      if (areWordsValid) {
        yield VerificationWordsValidState(event.originalWords);
      } else {
        yield VerificationWordsInvalidState(event.originalWords);
      }
    }
  }
}
