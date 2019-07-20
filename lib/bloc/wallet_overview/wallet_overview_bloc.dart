import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/repository/repositories.dart';
import 'bloc.dart';


/// [Bloc] implementation used to display the wallet overview to the
/// user inside the main application page
class WalletOverviewBloc
    extends Bloc<WalletOverviewEvent, WalletOverviewState> {
  final AccountsRepository accountRepo = BorsellinoInjector.get();
  final WalletRepository walletRepository = BorsellinoInjector.get();

  WalletOverviewBloc() {
    // Listen for account changes in order to properly update the wallet info
    accountRepo.getAccountStream().listen((account) {
      dispatch(LoadWalletDataEvent());
    });
  }

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
        print("Retrieved current wallet");

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
