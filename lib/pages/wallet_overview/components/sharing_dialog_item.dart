import 'package:flutter/material.dart';

AlertDialog sharingDialog({String address, BuildContext context}) {

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
          Text(address),
          SizedBox(height: 20),
          Row(children: <Widget>[
            Expanded(child: FlatButton(child: Text('Share'), onPressed: () {},)),
            Expanded(child: FlatButton(child: Text('Copy'), onPressed: () {},)),
          ],)
        ],
      ),
    ),
  );
}
