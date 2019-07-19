import 'package:borsellino/bloc/generate_mnemonic/bloc.dart';
import 'package:borsellino/bloc/generate_mnemonic/generate_mnemonic_event.dart';
import 'package:borsellino/bloc/generate_mnemonic/generate_mnemonic_state.dart';
import 'package:borsellino/pages/generate_mnemonic/components/generating_mnemonic_body.dart';
import 'package:borsellino/pages/generate_mnemonic/components/mnemonic_generated_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Page that allows the user to visualize a new mnemonic code generated
/// just for him.
class GenerateMnemonicPage extends StatelessWidget {
  static const routeName = "/generateMnemonic";

  @override
  Widget build(BuildContext context) {
    final GenerateMnemonicBloc bloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Create new mnemonic"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => bloc.dispatch(GenerateNewMnemonicEvent()),
          )
        ],
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is InitialGenerateMnemonicState) {
            // Tell to generate a new mnemonic
            bloc.dispatch(GenerateNewMnemonicEvent());
          }

          // The mnemonic is being generated
          if (state is GeneratingMnemonicState) {
            return GeneratingMnemonicBody();
          }

          // The mnemonic has been generated
          if (state is MnemonicGeneratedState) {
            return MnemonicGeneratedBody(state.mnemonic);
          }

          return Container();
        },
      ),
    );
  }
}
