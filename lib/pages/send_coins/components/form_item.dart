import 'package:flutter/material.dart';

class FormItem extends StatefulWidget {
  final fieldDescription;
  final fieldLabel;
  TextInputType keyboardType;

  FormItem({this.fieldDescription, this.fieldLabel, this.keyboardType});

  @override
  _FormItemState createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {

  final resultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Text(widget.fieldDescription, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          TextFormField(
            decoration: InputDecoration(labelText: widget.fieldLabel, alignLabelWithHint: true),
            keyboardType: widget.keyboardType,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: resultController,
          ),
        ],
      ),
    );
  }
}
