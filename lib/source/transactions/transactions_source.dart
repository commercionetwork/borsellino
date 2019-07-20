import 'dart:convert';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/transactions/std_public_key.dart';
import 'package:borsellino/models/transactions/std_signature.dart';
import 'package:borsellino/models/transactions/std_tx.dart';
import 'package:borsellino/source/sources.dart';
import 'package:borsellino/source/transactions/endpoints.dart';
import 'package:borsellino/source/transactions/transactions_helper.dart';
import 'package:borsellino/source/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// Source that needs to be used when working with transactions (creating,
/// signing and sending) .
class TransactionsSource {
  final http.Client httpClient;
  final AccountsSource accountsSource;

  TransactionsSource({
    @required this.httpClient,
    @required this.accountsSource,
  })  : assert(httpClient != null),
        assert(accountsSource != null);

  /// Broadcasts the given [stdTx] using the info contained
  /// inside the given [wallet].
  /// Returns the hash of the transaction once it has been send.
  Future<String> broadcastTransaction(Wallet wallet, StdTx stdTx) async {
    // Get the endpoint
    final baseUrl = wallet.account.chain.lcdUrl;
    final apiUrl = "$baseUrl${TransactionsEndpoints.BROADCAST}";

    // Build the request body
    final tx = jsonEncode(stdTx);
    final requestBody = {"tx": tx, "mode": "sync"};
    final requestBodyJson = jsonEncode(requestBody);

    // Get the response
    final response = await httpClient.post(apiUrl, body: requestBodyJson);
    checkResponse(response);

    // Get the Tx hash
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    if (!json.containsKey("hash")) {
      throw Exception("No hash inside response: $json");
    } else {
      return json["hash"];
    }
  }

  /// Given a [stdMessage] and an associated [memo], builds a [StdTx].
  Future<StdTx> _buildStdTx(
      Wallet wallet, StdMsg stdMessage, String memo) async {
    // Create the fee object
    final fee = StdFee(amount: [], gas: "200000");

    // Assemble the signature JSON object
    final jsonSignData = TransactionsHelper.assembleSignature(
      wallet: wallet,
      message: stdMessage,
      fee: fee,
      memo: memo,
    );

    // Get the private key
    final privateKey = await accountsSource.getPrivateKey(wallet.account);

    // Sign the message
    final signatureData = TransactionsHelper.signMessage(
      jsonSignData,
      privateKey,
    );

    // Get the compressed Base64 public key
    final pubKeyCompressed = signatureData.publicKey.Q.getEncoded(true);
    final pubKeyBase64 = base64Encode(pubKeyCompressed);

    // Build the StdPublicKey object
    final publicKey = StdPublicKey(
      type: "tendermint/PubKeySecp256k1",
      value: pubKeyBase64,
    );

    // Build the StdSignature
    final stdSignature = StdSignature(
      signature: signatureData.base64Signature,
      publicKey: publicKey,
    );

    // Assemble the transaction
    return StdTx(
      fee: fee,
      memo: memo,
      messages: [stdMessage],
      signatures: [stdSignature],
    );
  }

  /// Given a [MsgSend] and an associated [memo], returns a
  /// [StdTx] object made for that message.
  Future<StdTx> createSendTransaction({
    @required Wallet wallet,
    @required MsgSend message,
    @required String memo,
  }) async {
    // Build the standard message
    final stdMessage = StdMsg(
      type: "cosmos-sdk/MsgSend",
      value: message.toJson(),
    );

    return _buildStdTx(wallet, stdMessage, memo);
  }
}
