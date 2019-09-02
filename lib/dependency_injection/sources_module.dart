import 'package:borsellino/source/sources.dart';
import 'package:dependencies/dependencies.dart';

class SourcesModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindLazySingleton((injector, p) => ChainsSource(
            httpClient: injector.get(),
        converter: NetworkInfoConverter(),
          ))
      ..bindLazySingleton((injector, p) => ValidatorSource(
            accountsSource: injector.get(),
            httpClient: injector.get(),
            converter: ValidatorConverter(),
      ))..bindLazySingleton((injector, p) =>
        KeysSource(
          secureStorage: injector.get(),
          ))
      ..bindLazySingleton((injector, p) => WalletSource(
            keysSource: injector.get(),
        chainsSource: injector.get(),
      ))..bindLazySingleton((injector, p) =>
        AccountSource(
          walletSource: injector.get(),
          httpClient: injector.get(),
        ))
      ..bindLazySingleton((injector, p) => MnemonicSource());
  }
}
