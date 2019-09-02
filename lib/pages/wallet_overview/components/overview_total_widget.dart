import 'package:basic_utils/basic_utils.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:sacco/sacco.dart';

/// Contains the name and the total amount of the given [coin] that
/// the given [wallet] has.
class WalletTotalWidget extends StatelessWidget {
  final Account wallet;
  final StdCoin coin;

  const WalletTotalWidget({
    Key key,
    this.wallet,
    this.coin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the denom by falling back to the default one
    var denom = coin?.denom ?? wallet.wallet.networkInfo.defaultTokenDenom;

    // FIXME: This should be done in some other way
    if (denom.startsWith("u")) {
      denom = denom.substring(1);
    }

    final titleTextStyle = TextStyle(
      color: Theme.of(context).primaryColorDark,
      fontSize: FontSize.LARGE,
      fontWeight: FontWeight.bold,
    );

    final valueTextStyle = TextStyle(
      fontSize: FontSize.MEDIUM,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(StringUtils.capitalize(denom), style: titleTextStyle),
        Text(wallet.getTotal(coin).toStringAsFixed(6), style: valueTextStyle),
      ],
    );
  }
}
