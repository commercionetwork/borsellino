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
    final textStyle = TextStyle(
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(title, style: textStyle),
          SizedBox(height: 5),
          Text(amount.toStringAsFixed(6)),
        ],
      ),
    );
  }
}
