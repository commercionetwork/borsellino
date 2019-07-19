import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/wallet_overview/components/sharing_dialog_item.dart';
import 'package:flutter/material.dart';

class WalletAddressWidget extends StatelessWidget {
  final Wallet wallet;

  WalletAddressWidget(this.wallet);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'My Address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(
                      Icons.share,
                      size: 30,
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () => SharingDialog.show(context, wallet),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    wallet.account.address,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
