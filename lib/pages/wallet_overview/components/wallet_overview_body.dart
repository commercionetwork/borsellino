import 'package:borsellino/pages/wallet_overview/components/overview_address.dart';
import 'package:borsellino/pages/wallet_overview/components/overview_balance_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Container walletOverviewBody() {
  return Container(
    margin: EdgeInsets.all(20),
    child: Column(
      children: <Widget>[
        overviewAddress(),
        SizedBox(
          height: 50,
        ),
        overviewBalanceInfo(),
      ],
    ),
  );
}
