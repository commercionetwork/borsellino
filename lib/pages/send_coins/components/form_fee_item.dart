import 'package:flutter/material.dart';

class FormFeeItem extends StatefulWidget {

  int radioValue;

  FormFeeItem(this.radioValue);

  @override
  _FormFeeItemState createState() => _FormFeeItemState();
}

class _FormFeeItemState extends State<FormFeeItem> {


  void _handleRadioValueChange(int value){
    setState(() {
      widget.radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text('Fee Amount', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: <Widget>[
              Radio(value: 0, groupValue: widget.radioValue, onChanged: _handleRadioValueChange,),
              Text('0.000001'),
              Radio(value: 1, groupValue: widget.radioValue, onChanged: _handleRadioValueChange),
              Text('0.000250'),
              Radio(value: 2, groupValue: widget.radioValue, onChanged: _handleRadioValueChange),
              Text('0.002500'),
            ],
          )
        ],
      ),
    );
  }
}
