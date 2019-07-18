import 'package:borsellino/blocprov/blocproviders.dart';
import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:borsellino/theme/theme.dart';
import 'package:flutter/material.dart';

/// Main application
class BorsellinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: borsellinoTheme(),
      initialRoute: "/",
      routes: {
        "/": (context) => AddAccountPage(),
        ImportMnemonicPage.routeName: (context) => importMnemonicBlocProvider(),
        GenerateMnemonicPage.routeName: (context) => generateMnemonicBlocProvider(),
        VerifyMnemonicPage.routeName: (context) => verifyMnemonicBlocProvider(),
      },
    );
  }
}
