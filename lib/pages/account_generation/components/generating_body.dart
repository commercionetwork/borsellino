import 'package:flutter/material.dart';

/// Content of the AccountGenerationPage that is shown to the
/// user while the account is being generated.
class AccountGeneratingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text("Generating the account. This might take a while...")
        ],
      ),
    );
  }
}
