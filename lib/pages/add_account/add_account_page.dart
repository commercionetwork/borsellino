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
    const titleTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 28,
    );

    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: Image(
                image: NetworkImage(
                    "https://csharpdotchristiannageldotcom.files.wordpress.com/2018/08/unicorn.jpg?w=1200"),
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Borsellino", style: titleTextStyle),
                    Text("The Cosmos Hub wallet!", style: titleTextStyle)
                  ],
                ),
              ),
            ),
            Column(
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
            )
          ],
        ),
      ),
    );
  }
}
