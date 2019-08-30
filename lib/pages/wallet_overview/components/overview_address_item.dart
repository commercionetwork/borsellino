import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/wallet_overview/components/share_account_dialog.dart';
import 'package:borsellino/theme/sizes.dart';
import 'package:flutter/material.dart';

class WalletAddressWidget extends StatelessWidget {
  final Account wallet;

  WalletAddressWidget(this.wallet);

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: FontSize.LARGE,
      color: Theme.of(context).primaryColorDark,
    );

    final subTitleTextStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: FontSize.MEDIUM,
    );

    final valueTextStyle = TextStyle(
      fontSize: FontSize.SMALL,
    );

    const largeSeparator = SizedBox(height: 16);
    const smallSeparator = SizedBox(height: 8);

    return Card(
      color: Theme.of(context).primaryColorLight,
      elevation: 7,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text("My wallet", style: titleTextStyle),
            largeSeparator,
            Text("Chain:", style: subTitleTextStyle),
            Text(wallet.wallet.networkInfo.name, style: valueTextStyle),
            smallSeparator,
            Text("Address:", style: subTitleTextStyle),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(wallet.wallet.bech32Address, style: valueTextStyle),
            ),
            largeSeparator,
            IconButton(
              alignment: Alignment.centerRight,
              icon: Icon(
                Icons.share,
                size: 30,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () => SharingDialog.show(context, wallet),
            ),
          ],
        ),
      ),
    );
  }
}
