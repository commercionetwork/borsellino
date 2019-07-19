import 'package:meta/meta.dart';

class ChainInfoJson {
  final String id;
  final String iconUrl;
  final String name;
  final String lcdUrl;
  final String rpcUrl;
  final String bech32Hrp;

  ChainInfoJson({
    @required this.id,
    @required this.iconUrl,
    @required this.name,
    @required this.lcdUrl,
    @required this.rpcUrl,
    @required this.bech32Hrp,
  })  : assert(id != null),
        assert(name != null),
        assert(lcdUrl != null),
        assert(rpcUrl != null),
        assert(bech32Hrp != null);

  factory ChainInfoJson.fromJson(Map<String, dynamic> json) {
    return ChainInfoJson(
      id: json["id"],
      iconUrl: json["icon"],
      name: json["name"],
      lcdUrl: json["lcd_url"],
      rpcUrl: json["rpc_url"],
      bech32Hrp: json["bech32_hrp"],
    );
  }
}
