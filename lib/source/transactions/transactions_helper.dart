import 'dart:convert';
import 'dart:typed_data';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/transactions/map_sorter.dart';
import 'package:borsellino/source/transactions/transaction_signer.dart';
import 'package:hex/hex.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/export.dart';

class SignatureData {
  final String base64Signature;
  final ECPublicKey publicKey;

  SignatureData({this.base64Signature, this.publicKey});
}

/// Helper class used when creating and signing a transaction
class TransactionsHelper {
  /// Given a [Wallet], a [message] and a [memo], assembles
  /// a [StdSignatureMessage] and returns its representation as a JSON object
  /// string that must be later signed.
  static String assembleSignature({
    @required Wallet wallet,
    @required StdMsg message,
    @required StdFee fee,
    @required String memo,
  }) {
    // Create the signature object
    final signature = StdSignatureMessage(
      sequence: wallet.sequence,
      accountNumber: wallet.accountNumber,
      chainId: wallet.account.chain.id,
      fee: fee.toJson(),
      memo: memo,
      msgs: [message.toJson()],
    );

    // Convert the signature to a JSON and sort it
    final jsonSignature = signature.toJson();
    final sortedJson = MapSorter.sort(jsonSignature);

    // Encode the sorted JSON to a string
    return json.encode(sortedJson);
  }

  /// Uses the given [privateKey] in order to sign the provided [stdSignature]
  /// and returns the signature as a Base64 string.
  static SignatureData signMessage(String stdSignature, Uint8List privateKey) {
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
