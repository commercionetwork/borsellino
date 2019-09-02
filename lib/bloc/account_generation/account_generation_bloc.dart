import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/repository/repositories.dart';

import './bloc.dart';

class AccountGenerationBloc
    extends Bloc<AccountGenerationEvent, AccountGenerationState> {
  final AccountRepository repo = BorsellinoInjector.get();

  @override
  AccountGenerationState get initialState => InitialAccountGenerationState();

  @override
  Stream<AccountGenerationState> mapEventToState(
    AccountGenerationEvent event,
  ) async* {
    if (event is GenerateAccountEvent) {
      // Yield the load
      yield GeneratingAccountState();

      try {
        Account account;

        if (event.mnemonic != null) {
          // Create a new account account
          account = await repo.createAccount(event.mnemonic, event.networkInfo);
        } else if (event.account != null) {
          // Convert the existing account to a new one
          account = await repo.convertAccount(event.account, event.networkInfo);
        }

        print("Generated account address: ${account.wallet.bech32Address}");

        // Set the account as current
        repo.setAccountAsCurrent(account);

        // Tell the account has been generated properly
        yield GeneratedAccountState();
      } catch (exception) {
        print(exception);
        yield ErrorGeneratingAccountState(
          "Error while generating the account. Please try again later.",
        );
      }
    }
  }
}
