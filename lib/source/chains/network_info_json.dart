import 'package:meta/meta.dart';

class NetworkInfoJson {
  final String id;
  final String iconUrl;
  final String name;
  final String lcdUrl;
  final String rpcUrl;
  final String bech32Hrp;
  final String defaultTokenDenom;

  NetworkInfoJson({
    @required this.id,
    @required this.iconUrl,
    @required this.name,
    @required this.lcdUrl,
    @required this.rpcUrl,
    @required this.bech32Hrp,
    @required this.defaultTokenDenom,
  })  : assert(id != null),
        assert(name != null),
        assert(lcdUrl != null),
        assert(rpcUrl != null),
        assert(bech32Hrp != null),
        assert(defaultTokenDenom != null);

  factory NetworkInfoJson.fromJson(Map<String, dynamic> json) {
    return NetworkInfoJson(
      id: json["id"],
      iconUrl: json["icon"],
      name: json["name"],
      lcdUrl: json["lcd_url"],
      rpcUrl: json["rpc_url"],
      bech32Hrp: json["bech32_hrp"],
      defaultTokenDenom: json["token"],
    );
  }
}
