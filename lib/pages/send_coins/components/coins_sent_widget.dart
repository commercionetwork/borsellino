import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinsSentWidget extends StatelessWidget {
  final String txHash;

  const CoinsSentWidget({Key key, this.txHash}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SendCoinsBloc bloc = BlocProvider.of(context);

    const titleTextStyle = TextStyle(
      fontSize: FontSize.MEDIUM,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    );

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text("Transaction successfully sent", style: titleTextStyle),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Hash"),
              Text(txHash)
            ],
          ),
          SizedBox(height: 16),
          RaisedButton(
            child: Text("Send another"),
            onPressed: (){
              bloc.dispatch(ResetStateEvent());
            },
          )
        ],
      ),
    );
  }
}
