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
          _buildCoinData(wallet)
        ],
      ),
    );
  }

  Widget _buildCoinData(Wallet wallet) {

    // TODO: Handle multiple coins
    Coin coin;
    if (wallet.availableCoins.isNotEmpty) {
      coin = wallet.availableCoins[0];
    } else if (wallet.rewards.isNotEmpty) {
      coin = wallet.rewards[0];
    }

    return WalletBalanceWidget(wallet: wallet, coin: coin);
  }
}
