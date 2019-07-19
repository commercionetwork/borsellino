import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AccountGenerationBloc extends Bloc<AccountGenerationEvent, AccountGenerationState> {
  @override
  AccountGenerationState get initialState => InitialAccountGenerationState();

  @override
  Stream<AccountGenerationState> mapEventToState(
    AccountGenerationEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
