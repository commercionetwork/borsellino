import 'dart:typed_data';

import 'package:borsellino/crypto/bech32_encoder.dart';
import 'package:borsellino/models/models.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/export.dart';
import 'package:protobuf/protobuf.dart';

/// Allows to easily perform common operations related to the accounts
class AccountHelper {
  /// Cosmos constants
  static const _aminoPubKeyPrefix = "eb5ae987";

  // TODO: Let chains specify this?
  static const _pubKeyHrpPrefix = "pub";

  /// Creates an account data from the given public key and chain information.
  Future<Account> generateAccount(Uint8List publicKey, ChainInfo chain) async {
    // Public key encoding
    final bech32PublicKey = _deriveBech32PublicKey(publicKey, chain);

    // Address derivation
    final address = _deriveAddress(publicKey);
    final bech32address = _deriveBech32Address(address, chain);

    return Account(
      publicKey: publicKey,
      bech32Address: bech32address,
      bech32PublicKey: bech32PublicKey,
      chain: chain,
    );
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
    return Bech32Encoder.encode(chain.bech32Hrp, address);
  }
}
