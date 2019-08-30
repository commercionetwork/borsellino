import 'package:borsellino/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Contains the data of a wallet
class Account {
  final Wallet wallet;
  final List<StdCoin> availableCoins;
  final List<DelegationData> delegatedCoins;
  final List<UnbondingDelegation> unbondingDelegations;
  final List<StdCoin> rewards;

  Account({
    @required this.wallet,
    @required this.availableCoins,
    @required this.delegatedCoins,
    @required this.unbondingDelegations,
    @required this.rewards,
  })
      : assert(wallet != null),
        assert(availableCoins != null),
        assert(delegatedCoins != null),
        assert(unbondingDelegations != null),
        assert(rewards != null);

  double getTotal(StdCoin coin) {
    return getAvailable(coin) +
        getDelegated(coin) +
        getUnbonding(coin) +
        getRewards(coin);
  }

  double getAvailable(StdCoin coin) {
    final availableCoin = availableCoins
        .where((currentCoin) => currentCoin.denom == coin.denom)
        .toList();

    var availableAmount = 0.0;
    if (availableCoin.isNotEmpty) {
      availableAmount = double.parse(availableCoin[0].amount);
    }

    return availableAmount;
  }

  double getDelegated(StdCoin coin) {
    // TODO: Take into consideration the coin
    return delegatedCoins.fold(0.0, (total, data) => total + data.shares);
  }

  double getUnbonding(StdCoin coin) {
    // TODO: Take into consideration the coin
    return unbondingDelegations.fold(
        0.0, (total, data) => total + data.balance);
  }

  double getRewards(StdCoin coin) {
    // TODO: Take into consideration the coin
    return rewards
        .where((reward) => reward.denom == coin.denom)
        .fold(0.0, (total, reward) => total + double.parse(reward.amount));
  }
}
