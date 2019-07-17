import 'package:borsellino/repository/repositories.dart';
import 'package:dependencies/dependencies.dart';

class RepositoryModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindLazySingleton((injector, p) =>
          ValidatorsRepository(validatorsSource: injector.get()));
  }
}
