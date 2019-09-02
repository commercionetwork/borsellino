import 'package:flutter/material.dart';

class ErrorGeneratingAccountBody extends StatelessWidget {
  final String message;

  const ErrorGeneratingAccountBody({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Error generating the account"),
          Text(
            message,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
