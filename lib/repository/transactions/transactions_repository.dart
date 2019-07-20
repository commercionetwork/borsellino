import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/sources.dart';

/// Repository that must be used when working with transactions.
class TransactionsRepository {
  final TransactionsSource transactionsSource;

  TransactionsRepository(this.transactionsSource);

  /// Creates a [StdTx] object containing the given [message] and [memo].
  /// The message will be signed using the information contained inside the
  /// given [wallet].
  Future<StdTx> createSendTx({
    Wallet wallet,
    MsgSend message,
    String memo,
  }) async {
    return transactionsSource.createSendTransaction(
      wallet: wallet,
      memo: memo,
      message: message,
    );
  }

  /// Broadcasts the given [transaction] using the information contained
  /// inside the given [wallet].
  Future<String> broadcastTx({StdTx transaction, Wallet wallet}) async {
    return transactionsSource.broadcastTransaction(wallet, transaction);
  }
}
