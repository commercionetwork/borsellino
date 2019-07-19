import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/repository/repositories.dart';
import './bloc.dart';

class ChainSelectionBloc
    extends Bloc<ChainSelectionEvent, ChainSelectionState> {

  final ChainsRepository repository = BorsellinoInjector.get();

  @override
  ChainSelectionState get initialState => InitialChainSelectionState();

  @override
  Stream<ChainSelectionState> mapEventToState(
    ChainSelectionEvent event,
  ) async* {

    if (event is LoadChainsEvent) {
      // Emit the loading state
      yield LoadingChainsState();

      // TODO: Load the chains
      try {
        final chains = await repository.listChains();
        yield LoadedChainsState(chains);
      } catch (exception) {
        print("Chains error: $exception");
        yield ErrorChainsState();
      }
    }

  }
}
