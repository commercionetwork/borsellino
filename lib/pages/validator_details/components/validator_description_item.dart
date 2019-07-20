import 'package:borsellino/theme/sizes.dart';
import 'package:flutter/material.dart';

class ValidatorDescription extends StatelessWidget {
  final String description;

  ValidatorDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(fontSize: FontSize.SMALL, color: Colors.black54),
    );
  }
}
