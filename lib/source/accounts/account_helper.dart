import 'dart:typed_data';

import 'package:borsellino/crypto/bech32_encoder.dart';
import 'package:borsellino/models/models.dart';
import 'package:hex/hex.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/export.dart';
import 'package:protobuf/protobuf.dart';

/// Allows to easily perform common operations related to the accounts
class AccountHelper {
  /// Cosmos constants
  static const _aminoPubKeyPrefix = "eb5ae987";
  static const _derivePath = "m/44'/118'/0'/0/0";

  // TODO: Let chains specify this?
  static const _pubKeyHrpPrefix = "pub";

  /// Generates a private key from the given mnemonic code
  Future<Uint8List> generatePrivateKey(List<String> mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic.join(' '));
    return _derivePrivateKey(seed);
  }

  /// Creates an account data from the given private key and chain information.
  Future<Account> generateAccount(Uint8List privateKey, ChainInfo chain) async {
    // Public key derivation
    final publicKey = _derivePublicKey(privateKey);
    final bech32PublicKey = _deriveBech32PublicKey(publicKey, chain);

    // Address derivation
    final address = _deriveAddress(publicKey);
    final bech32address = _deriveBech32Address(address, chain);

    return Account(
      address: bech32address,
      publicKey: bech32PublicKey,
      chain: chain,
    );
  }

  /// Allows to derive a private key from the given seed
  Uint8List _derivePrivateKey(Uint8List seed) {
    final mainNode = HDWallet.fromSeed(seed);
    final derivedNode = mainNode.derivePath(_derivePath);
    return HEX.decode(derivedNode.privKey);
  }

  /// Derives a public key from the given private key
  Uint8List _derivePublicKey(Uint8List privateKey) {
    final secp256k1 = ECCurve_secp256k1();
    final point = secp256k1.G;
    final bigInt = BigInt.parse(HEX.encode(privateKey), radix: 16);
    final curvePoint = point * bigInt;
    final publicKey = curvePoint.getEncoded();
    return publicKey;
  }

  /// Encodes the given public key bytes into the Bech32 format
  /// for the given chain.
  String _deriveBech32PublicKey(Uint8List publicKey, ChainInfo chain) {
    final bufferWriter = CodedBufferWriter()
      ..writeField(1, PbFieldType.QY, publicKey);

    final protoSerialized = bufferWriter.toBuffer().toList()..removeAt(0);

    final prefixBuffer = HEX.decode(_aminoPubKeyPrefix);
    final buffer = [prefixBuffer, protoSerialized].expand((x) => x).toList();

    final data = Uint8List.fromList(buffer);

    return Bech32Encoder.encode(
      '${chain.bech32Hrp}$_pubKeyHrpPrefix',
      data,
    );
  }

  /// Derives the bytes representing the address from the given public key.
  Uint8List _deriveAddress(Uint8List publicKey) {
    final sha256Digest = SHA256Digest().process(publicKey);
    final address = RIPEMD160Digest().process(sha256Digest);
    return address;
  }

  /// Encodes the given address bytes into the Bech32 format
  /// specific for the given chain.
  String _deriveBech32Address(Uint8List address, ChainInfo chain) {
    return Bech32Encoder.encode('${chain.bech32Hrp}', address);
  }
}
