import 'package:flutter/material.dart';

/// Creates the dialog that is shown to the user when
/// a new account is being generated
Dialog generatingAccountDialog() {
  return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text("Generating the account")
          ],
        ),
      ),
  );
}