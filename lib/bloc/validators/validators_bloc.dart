import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:borsellino/bloc/validators/validators_event.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/repository/repositories.dart';
import './bloc.dart';

class ValidatorsBloc extends Bloc<ValidatorsEvent, ValidatorsState> {

  final ValidatorsRepository _repository = BorsellinoInjector.get();

  @override
  ValidatorsState get initialState => EmptyValidatorsState();

  @override
  Stream<ValidatorsState> mapEventToState(ValidatorsEvent event) async* {
    if (event is LoadValidatorsEvent) {

      // Inform we are loading the validators
      yield LoadingValidatorsState();

      try {
        // Get the list from the repository
        final List<Validator> validators = await _repository.getValidatorsList();

        // Notify we got the list
        yield ValidatorsLoadedState(validators: validators);

      } catch (exception) {
        print(exception);

        // Notify an error has occurred
        yield ValidatorsErrorState();
      }
    }
  }

}
