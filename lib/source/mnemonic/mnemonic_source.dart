import 'package:bip39/bip39.dart' as bip39;

class MnemonicSource {
  static const DIVIDER = " ";

  Future<List<String>> generateRandomMnemonic() async {
    final mnemonic = bip39.generateMnemonic(strength: 256);
    print("Generated mnemonic: $mnemonic");
    return mnemonic.split(DIVIDER);
  }

  Future<bool> validateMnemonic(List<String> mnemonic) async {
    return bip39.validateMnemonic(mnemonic.join(DIVIDER));
  }
}
