import 'package:borsellino/pages/send_coins/components/send_coins_form.dart';
import 'package:flutter/material.dart';

/// Represents the submit button inside the form
class FormSubmitItem extends StatelessWidget {
  final FormStatus formState;
  final Function onPressed;

  FormSubmitItem({
    @required this.formState,
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (formState == FormStatus.INVALID)
          Text(
            "Invalid data",
            style: TextStyle(color: Colors.red),
          ),
        RaisedButton(
          onPressed: onPressed,
          child: Text('Submit'),
        )
      ],
    );
  }
}
