import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class SharingDialog {
  static void show(BuildContext context, Account wallet) {
    showDialog(
      context: context,
      builder: (c) => _buildDialog(
        context: c,
        wallet: wallet,
      ),
    );
  }

  static AlertDialog _buildDialog({BuildContext context, Account wallet}) {
    final addressTextStyle = TextStyle(fontSize: FontSize.SMALL);

    final separator = SizedBox(height: 16);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      title: Align(
        alignment: Alignment.center,
        child: Text('Address'),
      ),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(
              wallet.wallet.networkInfo.iconUrl ?? DEFAULT_CHAIN_IMAGE_URL,
              height: 50,
            ),
            separator,
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                wallet.wallet.bech32Address,
                maxLines: 1,
                style: addressTextStyle,
              ),
            ),
            separator,
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Text('Share'),
                    onPressed: () {
                      _share(context, wallet);
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Text('Copy'),
                    onPressed: () {
                      _copy(context, wallet);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static void _copy(BuildContext context, Account wallet) {
    Clipboard.setData(ClipboardData(text: wallet.wallet.bech32Address));
    Navigator.pop(context);
  }

  static void _share(BuildContext context, Account account) {
    final wallet = account.wallet;
    Share.share("This is my ${wallet.networkInfo.name} address: ${wallet
        .bech32Address}");
    Navigator.pop(context);
  }
}
