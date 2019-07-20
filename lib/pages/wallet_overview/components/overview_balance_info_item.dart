import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/wallet_overview/components/overview_total_widget.dart';
import 'package:borsellino/theme/sizes.dart';
import 'package:flutter/material.dart';

import 'wallet_balance_item.dart';

/// Contains all the data related to the wallet amounts such as delegated,
/// available, etc.
class WalletBalanceWidget extends StatelessWidget {
  final Wallet wallet;
  final StdCoin coin;

  WalletBalanceWidget({this.wallet, this.coin});

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 8);

    return Card(
      margin: EdgeInsets.all(8),
      color: Theme.of(context).primaryColorLight,
      elevation: 7,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            WalletTotalWidget(wallet: wallet, coin: coin),
            Divider(color: Colors.black),
            WalletBalanceItem(
              title: "Available",
              amount: wallet.getAvailable(coin),
            ),
            spacer,
            WalletBalanceItem(
              title: "Delegated",
              amount: wallet.getDelegated(coin),
            ),
            spacer,
            WalletBalanceItem(
              title: "Unbonding",
              amount: wallet.getUnbonding(coin),
            ),
            spacer,
            WalletBalanceItem(
              title: "Reward",
              amount: wallet.getRewards(coin),
            ),
          ],
        ),
      ),
    );
  }
}
