import 'package:borsellino/models/models.dart';
import 'package:meta/meta.dart';

import 'coin.dart';

/// Contains the data of a wallet
class Wallet {
  final Account account;
  final String accountNumber;
  final String sequence;
  final List<Coin> coins;

  Wallet({
    @required this.account,
    @required this.accountNumber,
    @required this.sequence,
    @required this.coins,
  })  : assert(account != null),
        assert(accountNumber != null),
        assert(sequence != null),
        assert(coins != null);
}
