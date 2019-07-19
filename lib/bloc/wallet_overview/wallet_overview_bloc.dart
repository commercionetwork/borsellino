import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/repository/repositories.dart';
import 'bloc.dart';

class WalletOverviewBloc
    extends Bloc<WalletOverviewEvent, WalletOverviewState> {
  final WalletRepository walletRepository = BorsellinoInjector.get();

  @override
  WalletOverviewState get initialState => InitialWalletOverviewState();

  @override
  Stream<WalletOverviewState> mapEventToState(
    WalletOverviewEvent event,
  ) async* {
    if (event is LoadWalletDataEvent) {
      // Tell we are loading the data
      yield LoadingWalletDataState();

      try {
        // Get the wallet
        final wallet = await walletRepository.getCurrentWallet();

        // Tell that we loaded it
        yield WalletDataLoadedState(wallet);
      } catch (exception) {
        print("Error while loading the current wallet: $exception");

        // Tell there was an error
        yield WalletErrorState();
      }
    }
  }
}
