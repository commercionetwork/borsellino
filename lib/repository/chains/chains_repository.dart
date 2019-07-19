import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/sources.dart';

class ChainsRepository {
  final ChainsSource source;

  ChainsRepository(this.source);

  /// Lists all the supported chains.
  Future<List<ChainInfo>> listChains() async {
    return await source.getChains();
  }
}
