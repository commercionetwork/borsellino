import 'package:flutter/material.dart';

Container overviewBalanceInfo(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: EdgeInsets.all(6),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'CoinName',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                '0.0000000',
                style: TextStyle(fontSize: 18),
              ),
            ),
            alignment: Alignment.center,
          ),
          Align(
            child: Text('\$ 0.00'),
            alignment: Alignment.center,
          ),
          Divider(
            color: Colors.black,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  child: Text(
                    'Available',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,  fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            child: Text('0.000'),
            alignment: Alignment.center,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Delegated',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            child: Text('0.000'),
            alignment: Alignment.center,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Unbonding',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            child: Text('0.000'),
            alignment: Alignment.center,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Reward',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            child: Text('0.000'),
            alignment: Alignment.center,
          ),
        ],
      ));
}
