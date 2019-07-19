import 'package:borsellino/bloc/import_mnemonic/bloc.dart';
import 'package:borsellino/bloc/import_mnemonic/import_mnemonic_state.dart';
import 'package:flutter/material.dart';

/// Returns the content of the import mnemonic page
Widget buildImportMnemonicBody(
  ImportMnemonicState state,
  TextEditingController controller,
  ImportMnemonicBloc bloc,
) {

  // Clear up the input text
  if (state is EmptyMnemonicState) {
    controller.clear();
  }

  // Set the error
  var errorText;
  if (state is InvalidMnemonicLengthState) {
    errorText = "Invalid mnemonic length";
  }

  // Disable or enable the button
  var onPressed;
  if (state is ValidMnemonicLengthState) {
    onPressed = () => {};
  }

  // Create the text title style
  const textStyle = TextStyle(fontWeight: FontWeight.bold);

  // Return the body
  return Container(
    padding: EdgeInsets.all(8),
    child: Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Please enter your mnemonic code.",
              style: textStyle,
            ),
            Text(
              "Separate each word with a space.",
              style: textStyle,
            ),
          ],
        ),
        SizedBox(height: 8),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.text,
            minLines: 8,
            maxLines: 8,
            controller: controller,
            onChanged: (mnemonic) {
              bloc.dispatch(CurrentMnemonicChangedEvent(mnemonic));
            },
            decoration: InputDecoration(
              errorText: errorText,
              border: InputBorder.none,
              hintText: "gain lab name face ...",
              counterText: "${state.mnemonic.length} words",
            ),
          ),
        ),
        RaisedButton(
          child: Text("Continue"),
          onPressed: onPressed,
        )
      ],
    ),
  );
}
