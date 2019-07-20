import 'package:borsellino/blocprov/blocproviders.dart';
import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:borsellino/pages/validator_details/validator_details_page.dart';
import 'package:borsellino/theme/theme.dart';
import 'package:flutter/material.dart';

/// Main application
class BorsellinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: borsellinoTheme(),
      initialRoute: SplashScreenPage.routeName,
      routes: {
        // TODO: Change this with a splash screen
        SplashScreenPage.routeName: (context) => SplashScreenPage(),
        HomePage.routeName: (context) => HomePage(),
        ImportMnemonicPage.routeName: (context) => importMnemonicBlocProvider(),
        GenerateMnemonicPage.routeName: (context) => generateMnemonicBlocProvider(),
        ConfirmMnemonicPage.routeName: (context) => confirmMnemonicBlocProvider(),
        ChainSelectionPage.routeName: (context) => selectChainBlocProvider(),
        AccountSelectionPage.routeName: (context) => accountSelectionBlocProvider(),
        ValidatorDetailsPage.routeName: (context) => ValidatorDetailsPage()
      },
    );
  }
}
