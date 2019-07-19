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
  final AccountsRepository repository = BorsellinoInjector.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Try getting the current account and change
    // page accordingly to the result
    _getCurrentAccount(context);

    // Title text style
    const titleTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 28,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Borsellino", style: titleTextStyle),
                  Text("The Cosmos Hub wallet!", style: titleTextStyle)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getCurrentAccount(BuildContext context) {
    repository.getCurrentAccount().then((account) {
      if (account == null) {
        print("No latest account found");
        Navigator.pushNamedAndRemoveUntil(
          context,
          AddAccountPage.routeName,
          (_) => false,
        );
      } else {
        print("Latest account found");
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (_) => false,
        );
      }
    });
  }
}
