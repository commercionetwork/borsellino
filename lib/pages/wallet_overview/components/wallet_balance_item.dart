import 'package:borsellino/theme/sizes.dart';
import 'package:flutter/material.dart';

/// Represents a single entry inside the wallet balance.
/// It is composed of a title and an amount.
class WalletBalanceItem extends StatelessWidget {
  final String title;
  final double amount;

  const WalletBalanceItem({
    Key key,
    @required this.title,
    @required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final titleTextStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: FontSize.MEDIUM,
    );

    final valueTextStyle = TextStyle(
          fontSize: FontSize.SMALL,
    );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(title, style: titleTextStyle),
          Text(amount.toStringAsFixed(6), style: valueTextStyle),
        ],
      ),
    );
  }
}
