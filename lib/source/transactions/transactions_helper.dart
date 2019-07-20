import 'dart:convert';
import 'dart:typed_data';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/transactions/map_sorter.dart';
import 'package:borsellino/source/transactions/transaction_signer.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/export.dart';

/// Helper class used when creating and signing a transaction
class TransactionsHelper {
  /// Given a [Wallet], a [message] and a [memo], assembles
  /// a [StdSignature] and returns its representation as a JSON object
  /// string that must be later signed.
  Future<String> assembleSignature(
    Wallet wallet,
    Map<String, dynamic> message, {
    String memo,
  }) async {
    // Create the fee object
    final fee = StdFee(amount: [], gas: "200000");

    // Create the signature object
    final signature = StdSignature(
      sequence: wallet.sequence,
      accountNumber: wallet.accountNumber,
      chainId: wallet.account.chain.id,
      fee: fee,
      memo: memo,
      msgs: [message],
    );

    // Convert the signature to a JSON and sort it
    final jsonSignature = signature.toJson();
    final sortedJson = MapSorter.sort(jsonSignature);

    // Encode the sorted JSON to a string
    return json.encode(sortedJson);
  }

  /// Uses the given [privateKey] in order to sign the provided [stdSignature]
  /// and returns the signature as a Base64 string.
  Future<String> signMessage(String stdSignature, Uint8List privateKey) async {
    // Create a Sha256 of the message
    final bytes = utf8.encode(stdSignature);
    final hash = SHA256Digest().process(bytes);

    // Get the private key as a ECPrivateKey object
    final bobPrivateKeyInt = BigInt.parse(HEX.encode(privateKey), radix: 16);
    final bobPrivateKey = ECPrivateKey(bobPrivateKeyInt, ECCurve_secp256k1());

    // Get Bob's public key
    final secp256k1 = ECCurve_secp256k1();
    final point = secp256k1.G;
    final curvePoint = point * bobPrivateKey.d;
    final bobPublicKey = ECPublicKey(curvePoint, ECCurve_secp256k1());

    // Compute the signature
    final signature = TransactionSigner.deriveFrom(
      hash,
      bobPrivateKey,
      bobPublicKey,
    );

    // Encode the signature as a Base64 string and return it
    return base64Encode(signature);
  }
}
