import 'package:borsellino/models/models.dart';
import 'package:flutter/material.dart';

class SharingDialog {
  static void show(BuildContext context, Wallet wallet) {
    showDialog(
        context: context,
        builder: (c) => _buildDialog(
              context: c,
              wallet: wallet,
            ));
  }

  static AlertDialog _buildDialog({BuildContext context, Wallet wallet}) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Align(alignment: Alignment.center, child: Text('Address')),
      content: Container(
        height: 176,
        child: Column(
          children: <Widget>[
            Image.network(
              "https://commercio.network/wp-content/uploads/2018/04/logo_commercio_300-150x150.png",
              width: 50,
            ),
            SizedBox(height: 10),
            Text(wallet.account.address),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                    child: FlatButton(
                  child: Text('Share'),
                  onPressed: () {
                    // TODO
                  },
                )),
                Expanded(
                    child: FlatButton(
                  child: Text('Copy'),
                  onPressed: () {
                    // TODO
                  },
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
