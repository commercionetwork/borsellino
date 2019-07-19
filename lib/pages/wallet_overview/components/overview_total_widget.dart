import 'package:borsellino/models/models.dart';
import 'package:flutter/material.dart';

/// Contains the overall total of coins that the current wallet
/// has associated.
class WalletTotalWidget extends StatelessWidget {
  final Wallet wallet;

  const WalletTotalWidget({Key key, this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'CoinName',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              '0.0000000',
              style: TextStyle(fontSize: 18),
            ),
          ),
          alignment: Alignment.center,
        ),
        Align(
          child: Text('\$ 0.00'),
          alignment: Alignment.center,
        )
      ],
    );
  }
}
