import 'package:borsellino/models/wallet/coin.dart';

class AccountData {
  final String accountNumber;
  final String sequence;
  final List<Coin> coins;

  AccountData({this.accountNumber, this.sequence, this.coins});
}