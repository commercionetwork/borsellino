import 'dart:convert';
import 'dart:typed_data';

import 'package:borsellino/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:hex/hex.dart';
import 'package:borsellino/source/transactions/transaction_signer.dart';
import 'package:pointycastle/export.dart';
import 'package:meta/meta.dart';

import 'signature_data.dart';

class KeysSource {
  /// Constants
  static const DERIVATION_PATH = "m/44'/118'/0'/0/0";
  final FlutterSecureStorage secureStorage;

  KeysSource({
    @required this.secureStorage,
  })  : assert(secureStorage != null);

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

  /// Given an [account], returns the associated private key reading it
  /// from the secure storage.
  Future<Uint8List> _getPrivateKeyFromAccount(Account account) async {
    final publicKeyHex = HEX.encode(account.publicKey);
    final hexPrivateKey = await secureStorage.read(key: publicKeyHex);
    return HEX.decode(hexPrivateKey);
  }

  /// Signs the given [stdSignature] content using the private key associated
  /// with the given [account].
  Future<SignatureData> signStdSignature(
    String stdSignature,
    Account account,
  ) async {
    // Get the private key
    final privateKey = await _getPrivateKeyFromAccount(account);

    // Create a Sha256 of the message
    final bytes = utf8.encode(stdSignature);
    final hash = SHA256Digest().process(bytes);

    // Get the private key as a ECPrivateKey object
    final bobPrivateKeyInt = BigInt.parse(HEX.encode(privateKey), radix: 16);
    final ecPrivateKey = ECPrivateKey(bobPrivateKeyInt, ECCurve_secp256k1());

    // Get Bob's public key
    final secp256k1 = ECCurve_secp256k1();
    final point = secp256k1.G;
    final curvePoint = point * ecPrivateKey.d;
    final ecPublicKey = ECPublicKey(curvePoint, ECCurve_secp256k1());

    // Compute the signature
    final signature = TransactionSigner.deriveFrom(
      hash,
      ecPrivateKey,
      ecPublicKey,
    );

    // Encode the signature as a Base64 string and return it
    return SignatureData(
      base64Signature: base64Encode(signature),
      publicKey: ecPublicKey,
    );
  }
}
