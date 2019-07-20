import 'package:equatable/equatable.dart';

class SendData extends Equatable {
  final String recipient;
  final double amount;
  final double feeAmount;

  SendData({
    this.recipient = "",
    this.amount = 0.0,
    this.feeAmount = 0.0,
  }) : super([
          recipient,
          amount,
          feeAmount,
        ]);

  bool validate() => recipient.isNotEmpty && amount > 0.0 && feeAmount > 0.0;

  SendData copy({String recipient, double amount, double feeAmount}) =>
      SendData(
        recipient: recipient ?? this.recipient,
        amount: amount ?? this.amount,
        feeAmount: feeAmount ?? this.feeAmount,
      );

  @override
  String toString() =>
      "Recipient: $recipient - Amount: $amount - Fee: $feeAmount";
}
