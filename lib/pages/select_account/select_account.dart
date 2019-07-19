import 'package:borsellino/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/accounts_loaded_body.dart';
import 'components/loading_accounts_body.dart';

class AccountSelectionPage extends StatelessWidget {
  static const routeName = "/listAccounts";

  @override
  Widget build(BuildContext context) {
    final AccountSelectionBloc bloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Select an account"),
      ),
      body: BlocBuilder(
          bloc: bloc,
          builder: (_, AccountSelectionState state) {
            // Initial state
            if (state is InitialAccountSelectionState) {
              bloc.dispatch(LoadAccountsEvent());
            }

            // Loading state
            if (state is LoadingAccountsState) {
              return LoadingAccountsBody();
            }

            // Loaded state
            if (state is AccountsLoadedState) {
              return AccountsLoadedBody(
                accounts: state.accounts,
                callback: (account) {

                  // Set the selected account as current
                  bloc.selectAccount(account).then((_) {
                    Navigator.pop(context);
                  });
                },
              );
            }

            // Default
            return Column();
          }),
    );
  }
}
