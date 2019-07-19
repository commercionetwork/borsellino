import 'package:flutter/material.dart';

class LoadingAccountsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text("Retrieving the accounts info...")
        ],
      ),
    );
  }
}
