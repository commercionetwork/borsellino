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
              image: NetworkImage("https://i.redd.it/ravmjkbpojg21.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                color: Colors.white,
                child: Text("Import mnemonic"),
                onPressed: () {
                  Navigator.pushNamed(context, ImportMnemonicPage.routeName);
                },
              ),
              MaterialButton(
                color: Colors.white,
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
