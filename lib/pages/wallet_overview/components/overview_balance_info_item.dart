import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/wallet_overview/components/overview_total_widget.dart';
import 'package:flutter/material.dart';

/// Contains all the data related to the wallet amounts such as delegated,
/// available, etc.
class WalletOverviewWidget extends StatelessWidget {
  final Wallet wallet;

  WalletOverviewWidget(this.wallet);

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 5);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: EdgeInsets.all(6),
      child: Column(
        children: <Widget>[
          WalletTotalWidget(wallet: wallet),
          Divider(color: Colors.black),
//          WalletBalanceItem(title: "Available", amount: 0),
//          spacer,
//          WalletBalanceItem(title: "Delegated", amount: 0),
//          spacer,
//          WalletBalanceItem(title: "Unbonding", amount: 0),
//          spacer,
//          WalletBalanceItem(title: "Reward", amount: 0),
        ],
      ),
    );
  }
}
