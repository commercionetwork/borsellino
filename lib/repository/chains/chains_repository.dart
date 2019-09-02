import 'package:borsellino/source/sources.dart';
import 'package:sacco/sacco.dart';

class ChainsRepository {
  final ChainsSource source;

  ChainsRepository(this.source);

  /// Lists all the supported chains.
  Future<List<NetworkInfo>> listChains() async {
    return await source.getChains();
  }
}
