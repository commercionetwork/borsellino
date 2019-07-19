import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/wallet/delegations.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'coin.dart';

/// Contains the data of a wallet
class Wallet {
  final Account account;
  final String accountNumber;
  final String sequence;
  final List<Coin> availableCoins;
  final List<DelegationData> delegatedCoins;
  final List<UnbondingDelegation> unbondingDelegations;
  final List<Coin> rewards;

  Wallet({
    @required this.account,
    @required this.accountNumber,
    @required this.sequence,
    @required this.availableCoins,
    @required this.delegatedCoins,
    @required this.unbondingDelegations,
    @required this.rewards,
  })  : assert(account != null),
        assert(accountNumber != null),
        assert(sequence != null),
        assert(availableCoins != null),
        assert(delegatedCoins != null),
        assert(unbondingDelegations != null),
        assert(rewards != null);

  double getAvailable(Coin coin) {
    final availableCoin = availableCoins
        .where((currentCoin) => currentCoin.denom == coin.denom)
        .toList();

    var availableAmount = 0.0;
    if (availableCoin.isNotEmpty) {
      availableAmount = availableCoin[0].amount;
    }

    return availableAmount;
  }

  double getDelegated(Coin coin) {
    // TODO: Take into consideration the coin
    return delegatedCoins.fold(
      0.0,
      (total, data) => total + data.shares,
    );
  }

  double getUnbonding(Coin coin) {
    // TODO: Take into consideration the coin
    return unbondingDelegations.fold(
      0.0,
      (total, data) => total + data.balance,
    );
  }

  double getRewards(Coin coin) {
    // TODO: Take into consideration the coin
    return rewards
        .where((reward) => reward.denom == coin.denom)
        .fold(0.0, (total, reward) => total + reward.amount);
  }
}
