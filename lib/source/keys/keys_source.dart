import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hex/hex.dart';
import 'package:meta/meta.dart';

class KeysSource {
  /// Constants
  static const DERIVATION_PATH = "m/44'/118'/0'/0/0";
  final FlutterSecureStorage secureStorage;

  KeysSource({
    @required this.secureStorage,
  }) : assert(secureStorage != null);

  Future<void> saveWalletPrivateKey(String bech32Address,
      Uint8List privateKey,) async {
    secureStorage.write(
      key: bech32Address,
      value: HEX.encode(privateKey),
    );
  }

  /// Given an [account], returns the associated private key reading it
  /// from the secure storage.
  Future<Uint8List> getPrivateKeyFromAddress(String bech32Address) async {
    final hexPrivateKey = await secureStorage.read(key: bech32Address);
    return HEX.decode(hexPrivateKey);
  }
}
