import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borsellino/bloc/send_coins/send_coins_state.dart';
import 'package:borsellino/bloc/send_coins/send_data.dart';
import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/repository/repositories.dart';
import 'package:sacco/sacco.dart';

import './bloc.dart';

class SendCoinsBloc extends Bloc<SendCoinsEvent, SendCoinsState> {
  final AccountRepository walletRepository = BorsellinoInjector.get();
  final TransactionsRepository txRepo = BorsellinoInjector.get();

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
    final account = await walletRepository.getCurrentAccount();

    // Get the coin
    String coinDenom;
    if (account.availableCoins.isEmpty) {
      throw Exception("No coins available");
    } else {
      // TODO: Get this from the event
      coinDenom = account.availableCoins[0].denom;
    }

    // Build the fee
    final fee = StdFee(gas: "200000", amount: [
      StdCoin(
        amount: (sendData.feeAmount * TOKEN_MULTIPLICATION_FACTOR).toString(),
        denom: coinDenom,
      )
    ]);

    // Build the amount
    final amount = StdCoin(
      amount: (sendData.amount * TOKEN_MULTIPLICATION_FACTOR).toString(),
      denom: coinDenom,
    );

    // Build the standard message
    final stdMessage = StdMsg(
      type: "cosmos-sdk/MsgSend",
      value: MsgSend(
        amount: [amount],
        fromAddress: account.wallet.bech32Address,
        toAddress: sendData.recipient,
      ).toJson(),
    );

    // Create the StdTx
    final stdTx = txRepo.createStdTx(message: stdMessage, fee: fee);

    // Sign the StdTx
    final signedTx = await txRepo.signStdTx(account: account, stdTx: stdTx);

    // Try broadcasting the transaction
    final txHash = await txRepo.broadcastTx(
      transaction: signedTx,
      account: account,
    );
    return txHash;
  }
}
