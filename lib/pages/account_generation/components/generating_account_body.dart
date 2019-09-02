import 'package:flutter/material.dart';

/// Represents the body that is shown to the user when
/// a new account is being generated
class GeneratingAccountBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Generating the account"),
          SizedBox(height: 16),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
