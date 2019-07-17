import 'package:borsellino/dependency_injection/apis_module.dart';
import 'package:borsellino/dependency_injection/repositories_module.dart';
import 'package:borsellino/dependency_injection/sources_module.dart';
import 'package:dependencies/dependencies.dart';

class BorsellinoInjector {
  static final _injector = Injector.fromModules(modules: [
    ApisModule(),
    SourcesModule(),
    RepositoryModule(),
  ]);

  /// Gets a dependency from the container with optional [name] and [params].
  static T get<T>({String name, Params params}) {
    return _injector.get(name: name, params: params);
  }
}
