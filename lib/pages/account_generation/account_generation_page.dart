import 'package:borsellino/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/arguments.dart';
import 'components/generating_body.dart';
import 'components/generated_body.dart';

export 'components/arguments.dart';

/// Page that should be visualized when the user has input a mnemonic
/// somehow and has already selected a chain for which to generate an
/// account.
class AccountGenerationPage extends StatelessWidget {
  static const routeName = "/generateAccount";

  @override
  Widget build(BuildContext context) {
    final AccountGenerationArgs args =
        ModalRoute.of(context).settings.arguments;

    final AccountGenerationBloc bloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Account generation"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, AccountGenerationState state) {

            // Initial state, tell to generate the account
            if (state is InitialAccountGenerationState) {
              bloc.dispatch(GenerateAccountEvent(
                mnemonic: args.mnemonic,
                chainInfo: args.chainInfo,
              ));
            }

            if (state is GeneratingAccountState) {
              return AccountGeneratingBody();
            }

            if (state is AccountGeneratedState) {
              return AccountGeneratedBody(state.account);
            }

            return Column();
          },
        ),
      ),
    );
  }
}
