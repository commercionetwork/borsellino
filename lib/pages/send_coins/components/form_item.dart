import 'package:flutter/material.dart';

class FormItem extends StatelessWidget {
  final fieldDescription;
  final fieldLabel;
  TextInputType keyboardType;

  FormItem({this.fieldDescription, this.fieldLabel, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Text(fieldDescription, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          TextFormField(
            decoration: InputDecoration(labelText: fieldLabel, alignLabelWithHint: true),
            keyboardType: keyboardType,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
