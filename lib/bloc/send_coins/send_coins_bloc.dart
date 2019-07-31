import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:borsellino/bloc/send_coins/send_coins_state.dart';
import 'package:borsellino/bloc/send_coins/send_data.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/repository/repositories.dart';
import './bloc.dart';

class SendCoinsBloc extends Bloc<SendCoinsEvent, SendCoinsState> {
  final WalletRepository walletRepository = BorsellinoInjector.get();
  final TransactionsRepository transactionsRepository =
      BorsellinoInjector.get();

  @override
  SendCoinsState get initialState => InitialSendCoinsState(SendData());

  @override
  Stream<SendCoinsState> mapEventToState(
    SendCoinsEvent event,
  ) async* {
    if (event is ResetStateEvent) {
      yield InitialSendCoinsState(SendData());
    }

    if (event is SendCoinsParamsChangedEvent) {
      print("Received change event: ${event.sendData}");
      yield InitialSendCoinsState(event.sendData);
    }

    if (event is ValidateDataEvent) {
      print("Validating data");

      SendData sendData = SendData();
      if (currentState is InitialSendCoinsState) {
        sendData = currentState.sendData;
      }

      if (!sendData.validate()) {
        print("Invalid data: $sendData");
        yield InvalidSendCoinDataState(sendData);
      } else {
        yield ValidSendCoinDataState(sendData);
      }
    }

    if (event is SendCoinsRequestedEvent) {
      // Tell we are sending them
      yield SendingCoinsState(event.sendData);

      try {
        String txHash = await _sendTransaction(event);
        yield CoinsSentState(txHash: txHash);
      } catch (exception) {
        print("Error while sending coins: $exception");
        yield ErrorSendingCoinsState(event.sendData);
      }
    }
  }

  Future<String> _sendTransaction(SendCoinsRequestedEvent event) async {
    // Get the send data
    final sendData = event.sendData;

    // Get the wallet
    final wallet = await walletRepository.getCurrentWallet();

    // Get the coin
    StdCoin coin;
    if (wallet.availableCoins.isEmpty) {
      throw Exception("No coins available");
    } else {
      // TODO: Get this from the event
      coin = wallet.availableCoins[0];
    }

    // Build the fee
    final fee = StdFee(gas: "200000", amount: [
      StdCoin(
        amount: sendData.feeAmount,
        denom: coin.denom,
      )
    ]);

    // Build the amount
    final amount = StdCoin(
      amount: sendData.amount,
      denom: coin.denom,
    );

    // Compose the message
    final sendMsg = MsgSend(
        amount: [amount],
        fromAddress: wallet.account.bech32Address,
        toAddress: sendData.recipient);

    // Create the StdTx
    final stdTx = await transactionsRepository.createSendTx(
      message: sendMsg,
      wallet: wallet,
      fee: fee,
    );

    // Try broadcasting the transaction
    final txHash = await transactionsRepository.broadcastTx(
      transaction: stdTx,
      wallet: wallet,
    );
    return txHash;
  }
}
