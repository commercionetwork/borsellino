import 'dart:async';

import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/models/chain/chain_info.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/chains_list_body.dart';
import 'components/arguments.dart';

export 'components/arguments.dart';

/// Page used when the user needs to select a chain for which
/// to create an account.
class ChainSelectionPage extends StatefulWidget {
  static const routeName = "/selectChain";

  @override
  _ChainSelectionPageState createState() => _ChainSelectionPageState();
}

class _ChainSelectionPageState extends State<ChainSelectionPage> {
  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    final ChainSelectionBloc bloc = BlocProvider.of(context);

    final ChainSelectionArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Select a chain"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          bloc.dispatch(LoadChainsEvent());
          return _refreshCompleter.future;
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, ChainSelectionState state) {
            // Initial state
            if (state is InitialChainSelectionState) {
              bloc.dispatch(LoadChainsEvent());
            }

            // Loaded state
            if (state is LoadedChainsState) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return ChainListBody(
                chains: state.chains,
                callback: (chain) {
                  _generateAccount(bloc, args, chain, context);
                },
              );
            }

            // Error state
            if (state is ErrorChainsState) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Error loading the chains."),
                    Text(
                        "Please try again later or contact and admin if this persist.")
                  ],
                ),
              );
            }

            return Container(
              padding: EdgeInsets.all(16),
            );
          },
        ),
      ),
    );
  }

  /// Allows to generate a new account using the given [bloc],
  /// [args] and [chain].
  /// Once the generation has finished, it brings the user to the
  /// [HomePage].
  void _generateAccount(
    ChainSelectionBloc chainSelectionBloc,
    ChainSelectionArguments args,
    ChainInfo chain,
    BuildContext context,
  ) {
    // Generate the account
    chainSelectionBloc
        .generateAccount(
      mnemonic: args.mnemonic,
      account: args.account,
      chainInfo: chain,
    )
        .then((account) {
      // Go to the home page
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (_) => false,
      );
    });
  }
}
