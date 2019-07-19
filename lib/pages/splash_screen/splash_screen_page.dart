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

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Image(
              image: NetworkImage(
                  "http://www.meteoweb.eu/wp-content/uploads/2018/08/COSMOS-AzTEC-1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          Text("Borsellino")
        ],
      ),
    );
  }
}
