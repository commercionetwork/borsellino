import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/repository/repositories.dart';
import 'package:sacco/sacco.dart';

import './bloc.dart';

class ChainSelectionBloc
    extends Bloc<ChainSelectionEvent, ChainSelectionState> {
  final ChainsRepository chainsRepo = BorsellinoInjector.get();
  final AccountRepository accountsRepo = BorsellinoInjector.get();

  @override
  ChainSelectionState get initialState => InitialChainSelectionState();

  /// Used to generate an account.
  Future<void> generateAccount({
    List<String> mnemonic,
    Account account,
    NetworkInfo networkInfo,
  }) async {
    print("Generating a new account");

    if (mnemonic != null) {
      // Create a new account account
      account = await accountsRepo.createAccount(
        mnemonic,
        networkInfo,
      );
    } else if (account != null) {
      account = await accountsRepo.convertAccount(
        account,
        networkInfo,
      );
    } else {
      throw Exception(
          "No mnemonic or account provided. Cannot create a new account");
    }

    print("Generated account address: ${account.wallet.bech32Address}");

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
