import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:borsellino/repository/repositories.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  static const routeName = "/";

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  var showSelectAccount = false;
  final AccountsRepository repository = BorsellinoInjector.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Try getting the existing accounts to decide if the
    // button to select one should be visible or not
    _getAccounts();

    // Try getting the current account and change
    // page accordingly to the result
    _getCurrentAccount(context);

    // Title text style
    const titleTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    );

    // Subtitle text style
    const subTitleTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
    );

    // Buttons text style
    const buttonTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

    return Scaffold(
      body: Stack(
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
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Borsellino", style: titleTextStyle),
                        Text("The Cosmos Hub wallet", style: subTitleTextStyle)
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      if (showSelectAccount)
                        FlatButton(
                          child: Text(
                            "Select existing account",
                            style: buttonTextStyle,
                          ),
                          onPressed: () {
                            _selectAccount(context);
                          },
                        ),
                      FlatButton(
                        child: Text(
                          "Import wallet",
                          style: buttonTextStyle,
                        ),
                        onPressed: () {
                          _importWallet(context);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "Generate random wallet",
                          style: buttonTextStyle,
                        ),
                        onPressed: () {
                          _generateWallet(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectAccount(BuildContext context) {
    Navigator.pushNamed(context, AccountSelectionPage.routeName);
  }

  void _importWallet(BuildContext context) {
    Navigator.pushNamed(context, ImportMnemonicPage.routeName);
  }

  void _generateWallet(BuildContext context) {
    Navigator.pushNamed(context, GenerateMnemonicPage.routeName);
  }

  void _getAccounts() {
    repository.listAccounts().then((accounts) {
      if (accounts != null && accounts.isNotEmpty) {
        setState(() {
          showSelectAccount = true;
        });
      }
    });
  }

  void _getCurrentAccount(BuildContext context) {
    repository.getCurrentAccount().then((account) {
      if (account != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (_) => false,
        );
      }
    });
  }
}
