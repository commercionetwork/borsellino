import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'send_data.dart';

@immutable
abstract class SendCoinsEvent extends Equatable {
  final SendData sendData;
  SendCoinsEvent({this.sendData, List props = const []}) : super(props);
}

class SendCoinsParamsChangedEvent extends SendCoinsEvent {
  SendCoinsParamsChangedEvent(SendData sendData) : super(sendData: sendData);
}

class ValidateDataEvent extends SendCoinsEvent {
  ValidateDataEvent(SendData sendData) : super(sendData: sendData);
}

class SendCoinsRequestedEvent extends SendCoinsEvent {
  SendCoinsRequestedEvent(SendData sendData) : super(sendData: sendData);
}

class ResetStateEvent extends SendCoinsEvent {}
