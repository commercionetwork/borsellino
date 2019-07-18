import 'package:flutter/material.dart';

class GeneratingMnemonicBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Generating a new mnemonic code..."),
          SizedBox(height: 16),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
