import 'package:flutter/material.dart';

/// Page that is shown to the user the first time he opens up the application.
/// This should makes him go to the AddAccountPage to setup the first wallet.
class SetupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Image(
              image: NetworkImage("https://i.redd.it/ravmjkbpojg21.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                color: Colors.white,
                child: Text("Test"),
                onPressed: () => {},
              )
            ],
          )
        ],
      ),
    );
  }
}
