import 'dart:collection';
import 'dart:math';

import 'package:borsellino/source/mnemonic/mnemonic_source.dart';

class MnemonicRepository {
  final MnemonicSource mnemonicSource;

  MnemonicRepository(this.mnemonicSource);

  Future<List<String>> generateRandomMnemonic() async {
    return await mnemonicSource.generateRandomMnemonic();
  }

  Future<bool> validateMnemonic(List<String> mnemonic) async {
    return await mnemonicSource.validateMnemonic(mnemonic);
  }

  Future<Map<int, String>> getVerificationWords(List<String> mnemonic) async {
    // Get 6 words to generate
    final Map<int, String> words = SplayTreeMap();

    // Get 6 random words and for each one add an entry into the words map
    List.generate(6, (index) => index).forEach((_) {
      var index = Random().nextInt(mnemonic.length);

      while (words.containsKey(index)) {
        index = Random().nextInt(mnemonic.length);
      }

      words[index] = mnemonic[index];
    });

    return words;
  }

  Future<bool> verifyInsertedWords(
    Map<int, String> originalWords,
    Map<int, String> insertedWords,
  ) async {
    var allValid = true;
    originalWords.forEach((index, word) {
      allValid &= originalWords[index].trim() == insertedWords[index].trim();
    });

    return allValid;
  }
}
