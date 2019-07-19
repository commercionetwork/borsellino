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
      appBar: AppBar(
        title: Text("Add account"),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Import mnemonic"),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, ImportMnemonicPage.routeName);
                  },
                ),
                SizedBox(width: 16),
                RaisedButton(
                  child: Text("Generate new mnemonic"),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(
                        context, GenerateMnemonicPage.routeName);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
