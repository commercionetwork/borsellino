import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

class SharingDialog {
  static void show(BuildContext context, Wallet wallet) {
    showDialog(
      context: context,
      builder: (c) => _buildDialog(
        context: c,
        wallet: wallet,
      ),
    );
  }

  static AlertDialog _buildDialog({BuildContext context, Wallet wallet}) {
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
              wallet.account.chain.iconUrl ?? DEFAULT_CHAIN_IMAGE_URL,
              height: 50,
            ),
            separator,
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                wallet.account.address,
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

  static void _copy(BuildContext context, Wallet wallet) {
    Clipboard.setData(ClipboardData(text: wallet.account.address));
    Navigator.pop(context);
  }

  static void _share(BuildContext context, Wallet wallet) {
    final account = wallet.account;
    Share.share("This is my ${account.chain.name} address: ${account.address}");
    Navigator.pop(context);
  }
}
