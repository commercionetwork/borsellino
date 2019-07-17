import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/bloc/validators/validators_bloc.dart';
import 'package:borsellino/models/validators/validator_filter.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc provider that allows to create a Validators Page easily
BlocProvider validatorBlockProvider(ValidatorFilter filter) {
  return BlocProvider<ValidatorsBloc>(
    builder: (context) => ValidatorsBloc(),
    child: ValidatorsPage(filter),
  );
}
