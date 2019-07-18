import 'package:borsellino/pages/wallet_overview/components/wallet_overview_app_bar.dart';
import 'package:borsellino/pages/wallet_overview/components/wallet_overview_body.dart';
import 'package:flutter/material.dart';

class WalletOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: walletOverviewAppBar(),
      body: walletOverviewBody(),
    );
  }
}
