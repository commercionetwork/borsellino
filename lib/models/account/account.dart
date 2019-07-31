import 'dart:convert';
import 'dart:typed_data';

import 'package:borsellino/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

/// Contains the data of a single account that the
/// user can add and later user.
class Account {
  final Uint8List publicKey;

  final String bech32PublicKey;
  final String bech32Address;

  final ChainInfo chain;

  Account({
    @required this.publicKey,
    @required this.bech32PublicKey,
    @required this.bech32Address,
    @required this.chain,
  })  : assert(bech32Address != null),
        assert(publicKey != null),
        assert(bech32PublicKey != null),
        assert(chain != null);

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      publicKey: Base64Decoder().convert(json['publicKey'] as String),
      bech32PublicKey: json['bech32PublicKey'] as String,
      bech32Address: json['bech32Address'] as String,
      chain: ChainInfo.fromJson(json['chain'])
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'publicKey': Base64Encoder().convert(this.publicKey),
        'bech32PublicKey': this.bech32PublicKey,
        'bech32Address': this.bech32Address,
        'chain': this.chain.toJson()
      };
}
