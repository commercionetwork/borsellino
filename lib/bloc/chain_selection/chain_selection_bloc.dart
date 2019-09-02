import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/repository/repositories.dart';

import './bloc.dart';

class ChainSelectionBloc
    extends Bloc<ChainSelectionEvent, ChainSelectionState> {
  final ChainsRepository chainsRepo = BorsellinoInjector.get();

  @override
  ChainSelectionState get initialState => InitialChainSelectionState();

  @override
  Stream<ChainSelectionState> mapEventToState(
    ChainSelectionEvent event,
  ) async* {
    if (event is LoadChainsEvent) {
      // Emit the loading state
      yield LoadingChainsState();

      try {
        // Get the chains
        final chains = await chainsRepo.listChains();

        // Tell that the chains are loaded
        yield LoadedChainsState(chains);
      } catch (exception) {
        print("Chains error: $exception");

        // Tell there was an error
        yield ErrorChainsState();
      }
    }
  }
}
