import 'package:borsellino/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendingCoinsErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SendCoinsBloc bloc = BlocProvider.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Error sending the coins"),
            Text("Check your data and try again"),
            SizedBox(height: 16),
            RaisedButton(
              child: Text("Go back"),
              onPressed: () {
                bloc.dispatch(
                    SendCoinsParamsChangedEvent(bloc.currentState.sendData));
              },
            )
          ],
        ),
      ),
    );
  }
}
