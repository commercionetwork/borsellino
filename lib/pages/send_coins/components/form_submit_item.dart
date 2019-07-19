import 'package:flutter/material.dart';



class FormSubmitItem extends StatelessWidget {

  GlobalKey<FormState> _formKey;

  FormSubmitItem(this._formKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: RaisedButton(
        highlightColor: Colors.lightBlueAccent,
        elevation: 10,
        onPressed: () {
          if(_formKey.currentState.validate()){
            return null;
          }
        },
        child: Text('Sumbmit'),
      ),
    );
  }
}
