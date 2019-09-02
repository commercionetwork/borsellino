import 'package:borsellino/pages/pages.dart';
import 'package:flutter/material.dart';

class AccountGeneratedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Account generated successfully"),
          FlatButton(
            child: Text("Go to main page"),
            onPressed: () => _goToMainPage(context),
          ),
        ],
      ),
    );
  }

  void _goToMainPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomePage.routeName,
      (_) => false,
    );
  }
}
