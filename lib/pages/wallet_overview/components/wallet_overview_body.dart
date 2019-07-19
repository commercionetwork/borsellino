import 'package:borsellino/pages/wallet_overview/components/overview_address_item.dart';
import 'package:borsellino/pages/wallet_overview/components/overview_balance_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Container walletOverviewBody(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(20),
    child: Column(
      children: <Widget>[
        overviewAddress(context),
        SizedBox(
          height: 50,
        ),
        overviewBalanceInfo(context),
      ],
    ),
  );
}
