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
            endpoints: injector.get(),
            httpClient: injector.get(),
            converter: ValidatorConverter(),
          ))
      ..bindLazySingleton((injector, p) => MnemonicSource());
  }
}
