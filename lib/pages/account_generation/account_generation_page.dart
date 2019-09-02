import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/pages/account_generation/components/account_generated_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/arguments.dart';
import 'components/error_generating_account_body.dart';
import 'components/generating_account_body.dart';

export 'components/arguments.dart';

/// Page that is shown to the user when a new account is being generated.
class AccountGenerationPage extends StatelessWidget {
  static const routeName = "/generatingAccount";

  @override
  Widget build(BuildContext context) {
    final AccountGenerationBloc bloc = BlocProvider.of(context);

    final GenerateAccountArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Generating an account"),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, AccountGenerationState state) {
          if (state is InitialAccountGenerationState) {
            bloc.dispatch(GenerateAccountEvent(
              args.mnemonic,
              args.account,
              args.networkInfo,
            ));
          }

          if (state is GeneratingAccountState) {
            return GeneratingAccountBody();
          }

          if (state is ErrorGeneratingAccountState) {
            return ErrorGeneratingAccountBody(message: state.message);
          }

          if (state is GeneratedAccountState) {
            return AccountGeneratedBody();
          }

          return Container();
        },
      ),
    );
  }
}
