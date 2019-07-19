import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:flutter/material.dart';

/// Content of the AccountGenerationPage that is shown to the
/// user when the account has been properly generated.
class AccountGeneratedBody extends StatelessWidget {
  final Account account;

  AccountGeneratedBody(this.account);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Account generated successfully!"),
          SizedBox(height: 16),
          RaisedButton(
            child: Text("Start using Borsellino!"),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomePage.routeName,
                (_) => false,
              );
            },
          )
        ],
      ),
    );
  }
}
