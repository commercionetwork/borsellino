import 'package:borsellino/models/models.dart';

import 'chain_info_json.dart';

/// Allows to convert a ChainInfoJson into a ChainInfo object
class ChainInfoConverter {
  ChainInfo convert(ChainInfoJson info) {
    return ChainInfo(
      id: info.id,
      iconUrl: info.iconUrl,
      name: info.name,
      lcdUrl: info.lcdUrl,
      rpcUrl: info.rpcUrl,
      bech32Hrp: info.bech32Hrp,
      defaultTokenName: info.defaultTokenName,
    );
  }
}
