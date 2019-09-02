import 'package:sacco/sacco.dart';

import 'network_info_json.dart';

/// Allows to convert a NetworkInfoJson into a NetworkInfo object
class NetworkInfoConverter {
  NetworkInfo convert(NetworkInfoJson info) {
    return NetworkInfo(
      id: info.id,
      iconUrl: info.iconUrl,
      name: info.name,
      lcdUrl: info.lcdUrl,
      bech32Hrp: info.bech32Hrp,
      defaultTokenDenom: info.defaultTokenDenom,
    );
  }
}
