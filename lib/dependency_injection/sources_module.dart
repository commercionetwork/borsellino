import 'package:borsellino/source/accounts/account_helper.dart';
import 'package:borsellino/source/chains/chain_info_converter.dart';
import 'package:borsellino/source/sources.dart';
import 'package:borsellino/source/validators/validator_converter.dart';
import 'package:dependencies/dependencies.dart';

class SourcesModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindLazySingleton((injector, p) => ChainsSource(
            httpClient: injector.get(),
            converter: ChainInfoConverter(),
          ))
      ..bindLazySingleton((injector, p) => ValidatorSource(
            accountsSource: injector.get(),
            httpClient: injector.get(),
            converter: ValidatorConverter(),
          ))
      ..bindLazySingleton((injector, p) =>
          KeysSource(secureStorage: injector.get()))
      ..bindLazySingleton((injector, p) => AccountsSource(
            keysSource: injector.get(),
            chainsSource: injector.get(),
            accountHelper: AccountHelper(),
          ))
      ..bindLazySingleton((injector, p) => WalletSource(
            accountsSource: injector.get(),
            httpClient: injector.get(),
          ))
      ..bindLazySingleton((injector, p) => TransactionsSource(
            keysSource: injector.get(),
            httpClient: injector.get(),
            accountsSource: injector.get(),
          ))
      ..bindLazySingleton((injector, p) => MnemonicSource());
  }
}
