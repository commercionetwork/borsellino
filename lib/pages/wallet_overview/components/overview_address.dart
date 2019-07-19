import 'package:flutter/material.dart';


Container overviewAddress(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(),
      borderRadius: BorderRadius.circular(3),
    ),
    padding: EdgeInsets.all(6),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Text(
                  'My Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
            IconButton(
              icon: Icon(Icons.share),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: <Widget>[
            Text('comnet124ndkco8xzowu2jfgal1nfpol29078f')
          ],
        ),
      ],
    ),
  );
}
