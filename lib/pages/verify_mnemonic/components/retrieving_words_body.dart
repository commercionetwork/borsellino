import 'package:flutter/material.dart';

class RetrievingVerificationWordsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Retrieving random verification words"),
        SizedBox(height: 16),
        CircularProgressIndicator()
      ],
    );
  }
}
