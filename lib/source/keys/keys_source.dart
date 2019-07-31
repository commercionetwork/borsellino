import 'dart:typed_data';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/keys/keys_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:hex/hex.dart';

class KeysSource {
  /// Constants
  static const DERIVATION_PATH = "m/44'/118'/0'/0/0";

  final FlutterSecureStorage secureStorage;
  final KeysHelper keysHelper;

  KeysSource({
    @required this.secureStorage,
    @required this.keysHelper,
  })  : assert(secureStorage != null),
        assert(keysHelper != null);

  /// Derives the private key from the given [mnemonic].
  Future<Uint8List> derivePublicKeyKey(List<String> mnemonic) async {
    // Get the seed as a string
    final seed = bip39.mnemonicToSeed(mnemonic.join(' '));

    // Get the HD wallet from the seed
    final mainNode = HDWallet.fromSeed(seed);

    // Get the node from the derivation path
    final derivedNode = mainNode.derivePath(DERIVATION_PATH);

    // Read the node as the private key
    final privateKeyBytes = HEX.decode(derivedNode.privKey);

    // Get the curve data
    final secp256k1 = ECCurve_secp256k1();
    final point = secp256k1.G;

    // Compute the curve point associated to the private key
    final bigInt = BigInt.parse(HEX.encode(privateKeyBytes), radix: 16);
    final curvePoint = point * bigInt;

    // Get the public key
    final publicKeyBytes = curvePoint.getEncoded();

    // Save the private and public key
    final publicKeyHex = HEX.encode(publicKeyBytes);
    final privateKeyHex = HEX.encode(privateKeyBytes);
    secureStorage.write(key: publicKeyHex, value: privateKeyHex);

    // Return the key bytes
    return publicKeyBytes;
  }

  Future<>
}
