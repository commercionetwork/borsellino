import 'package:meta/meta.dart';

class ChainInfoJson {
  final String id;
  final String iconUrl;
  final String name;
  final String rpcUrl;
  final String bech32Hrp;

  ChainInfoJson({
    @required this.id,
    @required this.iconUrl,
    @required this.name,
    @required this.rpcUrl,
    @required this.bech32Hrp,
  })  : assert(id != null),
        assert(name != null),
        assert(rpcUrl != null),
        assert(bech32Hrp != null);

  factory ChainInfoJson.fromJson(Map<String, dynamic> json) {
    print("Converting chain JSON: $json");
    return ChainInfoJson(
      id: json["id"],
      iconUrl: json["icon"],
      name: json["name"],
      rpcUrl: json["rpc_url"],
      bech32Hrp: json["bech32_hrp"],
    );
  }
}
