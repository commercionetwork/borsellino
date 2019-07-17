import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/pages/home/home_page.dart';
import 'package:borsellino/theme/theme.dart';
import 'package:flutter/material.dart';

/// Main application
class BorsellinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: APP_NAME,
        theme: borsellinoTheme(),
        home: HomePage(),
    );
  }
}
