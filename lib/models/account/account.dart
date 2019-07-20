import 'package:borsellino/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

/// Contains the data of a single account that the
/// user can add and later user.
class Account {

  /// Bech 32 address
  final String address;

  /// Bech 32 public key
  final String publicKey;
  final ChainInfo chain;

  Account({
    @required this.address,
    @required this.publicKey,
    @required this.chain,
  })  : assert(address != null),
        assert(publicKey != null),
        assert(chain != null);
}
