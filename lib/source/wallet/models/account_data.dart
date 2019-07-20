import 'package:borsellino/models/transactions/std_coin.dart';

class AccountData {
  final String accountNumber;
  final String sequence;
  final List<StdCoin> coins;

  AccountData({this.accountNumber, this.sequence, this.coins});
}