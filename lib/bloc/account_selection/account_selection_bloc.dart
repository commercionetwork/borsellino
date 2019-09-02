import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/repository/repositories.dart';

import './bloc.dart';

class AccountSelectionBloc
    extends Bloc<AccountSelectionEvent, AccountSelectionState> {
  final AccountRepository accountsRepo = BorsellinoInjector.get();

  @override
  AccountSelectionState get initialState => InitialAccountSelectionState();

  @override
  Stream<AccountSelectionState> mapEventToState(
    AccountSelectionEvent event,
  ) async* {
    if (event is LoadAccountsEvent) {
      // Tell we are loading the accounts
      yield LoadingAccountsState();

      try {
        // Get the accounts
        final accounts = await accountsRepo.listAccounts();

        // Emit the new state
        yield AccountsLoadedState(accounts);
      } catch (exception) {
        print("Exception while loading accounts: $exception");

        // Emit the error state
        yield ErrorAccountsState();
      }
    }
  }

  /// Sets the given [account] as the current account, and returns it
  Future<Account> selectAccount(Account account) async {
    return await accountsRepo.setAccountAsCurrent(account);
  }
}
