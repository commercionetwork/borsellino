import 'dart:async';

import 'package:borsellino/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

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

    print(args.mnemonic);

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
            if (state is InitialChainSelectionState) {
              bloc.dispatch(LoadChainsEvent());
            }

            if (state is LoadedChainsState) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return ChainSelectionBody(
                chains: state.chains,
                callback: (chain) {
                  // TODO: Navigate to the account generation page
                },
              );
            }

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
}
