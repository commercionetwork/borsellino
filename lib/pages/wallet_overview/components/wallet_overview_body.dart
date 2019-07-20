import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/wallet_overview/components/overview_address_item.dart';
import 'package:borsellino/pages/wallet_overview/components/overview_balance_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Body that is displayed inside the wallet overview once the wallet
/// info is properly loaded.
class WalletOverviewBody extends StatelessWidget {
  final Wallet wallet;

  WalletOverviewBody(this.wallet);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          WalletAddressWidget(wallet),
          SizedBox(height: 16),
          ..._buildCoinData(wallet)
        ],
      ),
    );
  }

  List<Widget> _buildCoinData(Wallet wallet) {
    List<StdCoin> coins = List();
    if (wallet.availableCoins.isNotEmpty) {
      coins = wallet.availableCoins;
    } else if (wallet.rewards.isNotEmpty) {
      coins = wallet.rewards;
    } else {
      coins = [StdCoin(denom: wallet.account.chain.defaultTokenName, amount: 0.0)];
    }

    return coins
        .map((coin) => WalletBalanceWidget(wallet: wallet, coin: coin))
        .toList();
  }
}
