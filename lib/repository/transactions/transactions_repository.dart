import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/sources.dart';
import 'package:flutter/cupertino.dart';

/// Repository that must be used when working with transactions.
class TransactionsRepository {
  final TransactionsSource transactionsSource;

  TransactionsRepository(this.transactionsSource);

  /// Creates a [StdTx] object containing the given [message] and [memo].
  /// The message will be signed using the information contained inside the
  /// given [wallet].
  Future<StdTx> createStdTx({
    @required Wallet wallet,
    @required StdMsg message,
    @required StdFee fee,
    String memo = "",
  }) async {
    return transactionsSource.buildStdTx(
      wallet: wallet,
      memo: memo,
      stdMessage: message,
      fee: fee,
    );
  }

  /// Broadcasts the given [transaction] using the information contained
  /// inside the given [wallet].
  Future<String> broadcastTx({StdTx transaction, Wallet wallet}) async {
    return transactionsSource.broadcastStdTx(wallet, transaction);
  }
}
