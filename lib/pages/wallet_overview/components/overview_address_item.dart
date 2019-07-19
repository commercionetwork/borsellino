import 'package:borsellino/pages/wallet_overview/components/sharing_dialog_item.dart';
import 'package:flutter/material.dart';

Container overviewAddress(BuildContext context) {
  final address = 'comnet1rxm4f8kdelmd5vp0phuy09n7tpc487p8xrst7m';

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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  icon: Icon(Icons.share, size: 30,),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => showDialog(context: context, builder: (context) => sharingDialog(address: address, context: context)),
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
                child: Text(address,
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
