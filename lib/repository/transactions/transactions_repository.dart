import 'package:borsellino/models/transactions/std_tx.dart';
import 'package:borsellino/source/sources.dart';
import 'package:borsellino/source/transactions/messages/msg_send.dart';

class TransactionsRepository {
  final TransactionsSource transactionsSource;

  TransactionsRepository(this.transactionsSource);

  Future<StdTx> craeteSendTx(MsgSend message, String memo) async {
    return transactionsSource.createSendTransaction(
      memo: memo,
      message: message,
    );
  }
}
