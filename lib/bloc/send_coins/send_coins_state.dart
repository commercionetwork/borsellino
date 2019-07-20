import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'send_data.dart';

@immutable
abstract class SendCoinsState extends Equatable {
  final SendData sendData;

  SendCoinsState({this.sendData, List props = const []})
      : super([sendData, props]);

  @override
  String toString() => "Send coins state: $sendData";


}

class InitialSendCoinsState extends SendCoinsState {
  InitialSendCoinsState(SendData sendData) : super(sendData: sendData);
}

class InvalidSendCoinDataState extends InitialSendCoinsState {
  InvalidSendCoinDataState(SendData sendData) : super(sendData);
}

class ValidSendCoinDataState extends InitialSendCoinsState {
  ValidSendCoinDataState(SendData sendData) : super(sendData);
}

class SendingCoinsState extends SendCoinsState {
  SendingCoinsState(SendData sendData) : super(sendData: sendData);
}

class CoinsSentState extends SendCoinsState {
  final String txHash;

  CoinsSentState({
    SendData sendData,
    this.txHash,
  }) : super(
          sendData: sendData,
          props: [txHash],
        );
}

class ErrorSendingCoinsState extends SendCoinsState {
  ErrorSendingCoinsState(SendData sendData) : super(sendData: sendData);
}
