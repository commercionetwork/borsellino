import 'package:sacco/sacco.dart';

class AccountData {
  final String accountNumber;
  final String sequence;
  final List<StdCoin> coins;

  AccountData({this.accountNumber, this.sequence, this.coins});
}