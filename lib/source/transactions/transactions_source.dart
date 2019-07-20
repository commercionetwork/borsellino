import 'dart:convert';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/transactions/std_public_key.dart';
import 'package:borsellino/models/transactions/std_signature.dart';
import 'package:borsellino/models/transactions/std_tx.dart';
import 'package:borsellino/source/sources.dart';
import 'package:borsellino/source/transactions/messages/msg_send.dart';
import 'package:borsellino/source/transactions/transactions_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class TransactionsSource {
  final http.Client httpClient;
  final WalletSource walletSource;
  final AccountsSource accountsSource;

  TransactionsSource({
    @required this.httpClient,
    @required this.walletSource,
    @required this.accountsSource,
  })  : assert(httpClient != null),
        assert(walletSource != null),
        assert(accountsSource != null);

  Future<String> _broadcastTransaction() async {}

  /// Given a [stdMessage] and an associated [memo], builds a [StdTx].
  Future<StdTx> _buildStdTx(StdMsg stdMessage, String memo) async {
    // Get the wallet
    final wallet = await walletSource.getCurrentWallet();

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
    final stdTx = StdTx(
      fee: fee,
      memo: memo,
      messages: [stdMessage],
      signatures: [stdSignature],
    );

    print(stdTx.toJson());
  }

  /// Given a [MsgSend] and an associated [memo], returns a
  /// [StdTx] object made for that message.
  Future<StdTx> createSendTransaction({
    @required MsgSend message,
    @required String memo,
  }) async {
    // Build the standard message
    final stdMessage = StdMsg(
      type: "cosmos-sdk/MsgSend",
      value: message.toJson(),
    );

    _buildStdTx(stdMessage, memo);

    // TODO:
    return null;
  }
}
