import 'package:borsellino/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:sacco/sacco.dart';

/// Repository that must be used when working with transactions.
class TransactionsRepository {
  /// Creates a [StdTx] object containing the given [message] and [memo].
  /// The message will be signed using the information contained inside the
  /// given [wallet].
  StdTx createStdTx({
    @required StdMsg message,
    @required StdFee fee,
    String memo = "",
  }) {
    return TxBuilder.buildStdTx(stdMsgs: [message], memo: memo, fee: fee);
  }

  Future<StdTx> signStdTx({
    @required Account account,
    @required StdTx stdTx,
  }) async {
    return TxSigner.signStdTx(wallet: account.wallet, stdTx: stdTx);
  }

  /// Broadcasts the given [transaction] using the information contained
  /// inside the given [account].
  Future<String> broadcastTx({
    StdTx transaction,
    Account account,
  }) async {
    return TxSender.broadcastStdTx(wallet: account.wallet, stdTx: transaction);
  }
}
