import 'package:borsellino/bloc/verify_mnemonic/verify_mnemonic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef void VerificationCallBack(
  Map<int, String> randomWords,
  Map<int, String> insertedWords,
);

class VerificationWordsGeneratedBody extends StatefulWidget {
  final List<String> mnemonic;
  final Map<int, String> verificationWords;
  final VerificationCallBack callBack;
  final bool areWordsInvalid;

  VerificationWordsGeneratedBody({
    @required this.mnemonic,
    @required this.verificationWords,
    @required this.callBack,
    @required this.areWordsInvalid,
  });

  @override
  _VerificationWordsGeneratedBodyState createState() =>
      _VerificationWordsGeneratedBodyState();
}

class _VerificationWordsGeneratedBodyState
    extends State<VerificationWordsGeneratedBody> {
  Map<int, TextEditingController> _textControllers;

  @override
  void initState() {
    super.initState();

    // Build some text controllers
    _textControllers = widget.verificationWords
        .map((index, _) => MapEntry(index, TextEditingController()));
  }

  @override
  Widget build(BuildContext context) {
    final VerifyMnemonicBloc bloc = BlocProvider.of(context);

    return SingleChildScrollView(
      child: BlocBuilder(
        bloc: bloc,
        builder: (_, state) {
          print(state);

          return Column(
            children: <Widget>[
              ..._buildWordsInputs(),
              SizedBox(height: 16),
              if (widget.areWordsInvalid)
                Text(
                  "Invalid words",
                  style: TextStyle(color: Colors.red),
                ),
              RaisedButton(
                child: Text("Verify"),
                onPressed: _verifyWords,
              ),
            ],
          );
        },
      ),
    );
  }

  void _verifyWords() {
    // Call the callback with the proper parameters
    widget.callBack(
      widget.verificationWords,
      _textControllers.map((index, controller) {
        return MapEntry(index, controller.text);
      }),
    );
  }

  /// Builds a list of TextFormField based on the verification words that
  /// have been set into the widget.
  List<TextFormField> _buildWordsInputs() {
    return widget.verificationWords
        .map((index, _) {
          final textField = TextFormField(
            onFieldSubmitted: (_) => {},
            controller: _textControllers[index],
            decoration:
                InputDecoration(labelText: "Insert word number ${index + 1}"),
          );

          return MapEntry(index, textField);
        })
        .values
        .toList();
  }
}
