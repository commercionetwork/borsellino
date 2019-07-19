import 'package:flutter/material.dart';

Container overviewBalanceInfo(BuildContext context){
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
                child: Text(
                  'CoinName',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    '0.0000000',
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          ),
          Align(
            child: Text('\$ 0.00'),
            alignment: Alignment.bottomRight,
          ),
          Divider(
            color: Colors.black,
          ),
          Row(children: <Widget>[Expanded(child: Text('Available', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),), Text('0.000')],),
          SizedBox(height: 5,),
          Row(children: <Widget>[Expanded(child: Text('Delegated', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),), Text('0.000')],),
          SizedBox(height: 5,),
          Row(children: <Widget>[Expanded(child: Text('Unbonding', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),), Text('0.000')],),
          SizedBox(height: 5,),
          Row(children: <Widget>[Expanded(child: Text('Reward',    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),), Text('0.000')],),
          SizedBox(height: 5,),
        ],
      ));
}
