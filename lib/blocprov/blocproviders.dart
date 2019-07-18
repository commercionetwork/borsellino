import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/models/validators/validator_filter.dart';
import 'package:borsellino/pages/generate_mnemonic/generate_mnemonic_page.dart';
import 'package:borsellino/pages/import_mnemonic/import_mnemonic_page.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc provider that allows to create a Validators Page easily
BlocProvider validatorBlockProvider(ValidatorFilter filter) {
  return BlocProvider<ValidatorsBloc>(
    builder: (context) => ValidatorsBloc(),
    child: ValidatorsPage(filter),
  );
}

BlocProvider importMnemonicBlocProvider() {
  return BlocProvider<ImportMnemonicBloc>(
    builder: (context) => ImportMnemonicBloc(),
    child: ImportMnemonicPage(),
  );
}

BlocProvider generateMnemonicBlocProvider() {
  return BlocProvider<GenerateMnemonicBloc>(
    builder: (context) => GenerateMnemonicBloc(),
    child: GenerateMnemonicPage(),
  );
}

BlocProvider verifyMnemonicBlocProvider() {
  return BlocProvider<VerifyMnemonicBloc>(
    builder: (context) => VerifyMnemonicBloc(),
    child: VerifyMnemonicPage(),
  );
}