import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

/// Contains all the data that a chain must provide in order
/// to be selectable when creating a new wallet.
class ChainInfo {
  final String id;
  final String iconUrl;
  final String name;
  final String lcdUrl;
  final String rpcUrl;

  // Bech32 Human Readable part used to create the addresses
  final String bech32Hrp;

  ChainInfo({
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
}
