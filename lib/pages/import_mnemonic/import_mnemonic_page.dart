import 'package:borsellino/bloc/import_mnemonic/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/app_bar.dart';
import 'components/body_builder.dart';

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
        builder: (BuildContext context, ImportMnemonicState state) =>
            buildImportMnemonicBody(state, _textEditController, bloc),
      ),
    );
  }
}
