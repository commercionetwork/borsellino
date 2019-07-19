import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/bloc/import_mnemonic/bloc.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/app_bar.dart';

/// Page that allows the user to import an existing mnemonic code in order
/// to generate the account.
class ImportMnemonicPage extends StatefulWidget {
  static const routeName = "/importMnemonic";

  @override
  _ImportMnemonicPageState createState() => _ImportMnemonicPageState();
}

class _ImportMnemonicPageState extends State<ImportMnemonicPage> {
  final TextEditingController _textEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ImportMnemonicBloc bloc = BlocProvider.of<ImportMnemonicBloc>(context);

    return Scaffold(
      appBar: appBar(bloc),
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, ImportMnemonicState state) {
          // Create the text title style
          const textStyle = TextStyle(fontWeight: FontWeight.bold);

          // Clear up the input text
          if (state is EmptyMnemonicState) {
            _textEditController.clear();
          }

          // Set the error
          var errorText;
          if (state is InvalidMnemonicLengthState) {
            errorText = "Invalid mnemonic length";
          }

          var onPressed;
          if (state is ValidMnemonicLengthState) {
            onPressed = () {
              _createAccount(context, _textEditController.text);
            };
          }

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
                    controller: _textEditController,
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
        },
      ),
    );
  }

  /// Navigates the user to the page where he can choose the chain of
  /// destination and create a new account starting from the given [mnemonic].
  void _createAccount(BuildContext context, String mnemonicText) {
    List<String> mnemonic = mnemonicText.split(" ");
    Navigator.pushNamed(context, ChainSelectionPage.routeName,
        arguments: ChainSelectionArguments(
          mnemonic: mnemonic,
        ));
  }
}
