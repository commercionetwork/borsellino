import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:borsellino/bloc/account_generation/account_generation_event.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/repository/repositories.dart';
import './bloc.dart';

class AccountGenerationBloc
    extends Bloc<AccountGenerationEvent, AccountGenerationState> {
  final AccountsRepository repository = BorsellinoInjector.get();

  @override
  AccountGenerationState get initialState => InitialAccountGenerationState();

  @override
  Stream<AccountGenerationState> mapEventToState(
    AccountGenerationEvent event,
  ) async* {
    if (event is GenerateAccountEvent) {
      // Tell we are generating it
      yield GeneratingAccountState(chain: event.chainInfo);

      try {
        // Create the account
        final account = await repository.createAccount(
          event.mnemonic,
          event.chainInfo,
        );

        print("Generated account: $account");

        // Set the account as current
        repository.setAccountAsCurrent(account);

        yield AccountGeneratedState(account);
      } catch (exception) {
        print("Error while generating account: $exception");
        yield ErrorGeneratingAccountState();
      }
    }
  }
}
