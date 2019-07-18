import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/pages/setup/setup_page.dart';
import 'package:borsellino/pages/wallet_overview/wallet_overview_page.dart';
import 'package:borsellino/theme/theme.dart';
import 'package:flutter/material.dart';

/// Main application
class BorsellinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: APP_NAME,
        theme: borsellinoTheme(),
        home: WalletOverviewPage(),
    );
  }
}
