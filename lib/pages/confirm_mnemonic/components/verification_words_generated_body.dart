import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef void VerificationCallBack(
  Map<int, String> randomWords,
  Map<int, String> insertedWords,
);

enum VerificationStatus { UNKNOWN, VALID, INVALID }

/// Represents the body that is shown to the user when a list
/// of verification words has been generated and should be properly
/// inserted from the user.
class VerificationWordsGeneratedBody extends StatefulWidget {
  final List<String> mnemonic;
  final Map<int, String> verificationWords;
  final VerificationCallBack callBack;
  final VerificationStatus verificationStatus;

  VerificationWordsGeneratedBody({
    @required this.mnemonic,
    @required this.verificationWords,
    @required this.callBack,
    @required this.verificationStatus,
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
    final ConfirmMnemonicBloc bloc = BlocProvider.of(context);

    return SingleChildScrollView(
      child: BlocBuilder(
        bloc: bloc,
        builder: (_, state) {
          print(state);

          return Column(
            children: <Widget>[
              ..._buildWordsInputs(),
              SizedBox(height: 16),
              if (widget.verificationStatus == VerificationStatus.INVALID)
                Text(
                  "Invalid words",
                  style: TextStyle(color: Colors.red),
                ),
              if (widget.verificationStatus == VerificationStatus.VALID)
                Text(
                  "Mnemonic correct!",
                  style: TextStyle(color: Colors.green),
                ),
              if (widget.verificationStatus != VerificationStatus.VALID)
                RaisedButton(
                  child: Text("Verify"),
                  onPressed: _verifyWords,
                ),
              if (widget.verificationStatus == VerificationStatus.VALID)
                RaisedButton(
                  child: Text("Continue"),
                  onPressed: _continue,
                )
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

  void _continue() {
    final chainSelectionArgs = ChainSelectionArguments(
      mnemonic: widget.mnemonic,
    );

    // Navigate to a new page
    Navigator.of(context).pushNamed(
      ChainSelectionPage.routeName,
      arguments: chainSelectionArgs,
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
