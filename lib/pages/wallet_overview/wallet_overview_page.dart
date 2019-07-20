import 'dart:async';

import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/wallet_overview/components/wallet_overview_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletOverviewPage extends StatefulWidget {
  @override
  _WalletOverviewPageState createState() => _WalletOverviewPageState();
}

class _WalletOverviewPageState extends State<WalletOverviewPage> {
  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    final WalletOverviewBloc bloc = BlocProvider.of(context);

    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          bloc.dispatch(LoadWalletDataEvent());
          return _refreshCompleter.future;
        },
        child: ListView(
          children: <Widget>[
            BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, WalletOverviewState state) {
                // Initial state
                if (state is InitialWalletOverviewState) {
                  bloc.dispatch(LoadWalletDataEvent());
                }

                // Loading
                if (state is WalletDataLoadedState) {
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                  return WalletOverviewBody(state.wallet);
                }

                // Error
                if (state is WalletErrorState) {
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Error loading the wallet data."),
                        Text(
                            "Please try again later or contact and admin if this persist.")
                      ],
                    ),
                  );
                }

                return Container(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text("Loading data..."),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
