import 'package:basic_utils/basic_utils.dart';
import 'package:borsellino/models/models.dart';
import 'package:flutter/material.dart';

/// Contains the overall total of coins that the current wallet
/// has associated.
class WalletTotalWidget extends StatelessWidget {
  final Wallet wallet;
  final Coin coin;

  const WalletTotalWidget({
    Key key,
    this.wallet,
    this.coin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Get the whole amount
    final availableCoin = wallet.availableCoins
        .where((currentCoin) => currentCoin.denom == coin.denom)
        .toList();

    var denom = coin?.denom ?? wallet.account.chain.defaultTokenName;

    var availableAmount = 0.0;
    if (availableCoin.isNotEmpty) {
      availableAmount = availableCoin[0].amount;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          StringUtils.capitalize(denom),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          availableAmount.toStringAsFixed(6),
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
