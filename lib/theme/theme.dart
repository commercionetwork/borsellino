import 'package:flutter/material.dart';

ThemeData borsellinoTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textSelectionColor: Colors.white,
    primarySwatch: Colors.indigo,
    accentColor: Colors.blueAccent,
    buttonColor: Colors.blueAccent,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
