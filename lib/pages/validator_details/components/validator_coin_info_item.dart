import 'package:borsellino/theme/sizes.dart';
import 'package:flutter/material.dart';

class ValidatorCoinInfo extends StatelessWidget {
  final String text;
  final FontWeight weight;

  ValidatorCoinInfo({this.text, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: FontSize.MEDIUM, fontWeight: weight),);
  }
}
