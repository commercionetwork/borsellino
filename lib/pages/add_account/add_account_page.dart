import 'package:flutter/material.dart';
import 'package:borsellino/pages/pages.dart';

/// Dialog that allows the user to add an account by selecting from two
/// different options:
/// 1. Using an existing mnemonic code
/// 2. Generating a new mnemonic code
///
/// It is inside this page that the user should choose for which chain to
/// create the account.
class AddAccountDialog  {

  static void show(BuildContext context) {
    showDialog(context: context, builder: (c) => _buildDialog(c));
  }

  static Dialog _buildDialog(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
                "Do you with to import a wallet mnemonic or generate a new one?"),
            SizedBox(height: 16),
            FlatButton(
              child: Text("Import wallet"),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  ImportMnemonicPage.routeName,
                );
              },
            ),
            SizedBox(height: 4),
            FlatButton(
              child: Text("Generate random mnemonic"),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  GenerateMnemonicPage.routeName,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}