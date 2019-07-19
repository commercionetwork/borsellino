import 'package:flutter/material.dart';
import 'package:borsellino/pages/pages.dart';

/// Page that allows the user to add an account by selecting from two
/// different options:
/// 1. Using an existing mnemonic code
/// 2. Generating a new mnemonic code
///
/// It is inside this page that the user should choose for which chain to
/// create the account.
class AddAccountPage extends StatelessWidget {
  static const routeName = "/addAccount";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Image(
              image: NetworkImage("https://coincodex.com/en/resources/images//admin/news/atom-token-transfers/cosmos-stars.jpg:resizeboxcropjpg?1580x888"),
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Import mnemonic"),
                onPressed: () {
                  Navigator.pushNamed(context, ImportMnemonicPage.routeName);
                },
              ),
              RaisedButton(
                child: Text("Generate new mnemonic"),
                onPressed: () {
                  Navigator.pushNamed(context, GenerateMnemonicPage.routeName);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
