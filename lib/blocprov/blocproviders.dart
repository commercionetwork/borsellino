import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/bloc/wallet_overview/wallet_overview_bloc.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:borsellino/pages/wallet_overview/wallet_overview_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borsellino/models/models.dart';

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

BlocProvider confirmMnemonicBlocProvider() {
  return BlocProvider<ConfirmMnemonicBloc>(
    builder: (context) => ConfirmMnemonicBloc(),
    child: ConfirmMnemonicPage(),
  );
}

BlocProvider selectChainBlocProvider() {
  return BlocProvider<ChainSelectionBloc> (
    builder: (context) => ChainSelectionBloc(),
    child: ChainSelectionPage(),
  );
}

BlocProvider accountSelectionBlocProvider() {
  return BlocProvider<AccountSelectionBloc>(
    builder: (context) => AccountSelectionBloc(),
    child: AccountSelectionPage(),
  );
}

BlocProvider walletOverviewWalletProvider() {
  return BlocProvider<WalletOverviewBloc>(
    builder: (context) => WalletOverviewBloc(),
    child: WalletOverviewPage(),
  );
}

BlocProvider sendCoinsBlocProvider() {
  return BlocProvider<SendCoinsBloc>(
    builder: (context) => SendCoinsBloc(),
    child: SendCoinsPage(),
  );
}