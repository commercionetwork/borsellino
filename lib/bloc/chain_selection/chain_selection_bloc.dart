import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/repository/repositories.dart';
import './bloc.dart';

class ChainSelectionBloc
    extends Bloc<ChainSelectionEvent, ChainSelectionState> {
  final ChainsRepository chainsRepo = BorsellinoInjector.get();
  final AccountsRepository accountsRepo = BorsellinoInjector.get();

  @override
  ChainSelectionState get initialState => InitialChainSelectionState();

  Future<void> generateAccount({
    List<String> mnemonic,
    Account account,
    ChainInfo chainInfo,
  }) async {
    if (mnemonic != null) {
      // Create a new account account
      account = await accountsRepo.createAccount(
        mnemonic,
        chainInfo,
      );
    } else if (account != null) {
      account = await accountsRepo.convertAccount(
        account,
        chainInfo,
      );
    } else {
      throw Exception(
          "No mnemonic or account provided. Cannot create a new account");
    }

    print("Generated account address: ${account.address}");

    // Set the account as current
    accountsRepo.setAccountAsCurrent(account);
  }

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
