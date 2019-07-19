import 'package:borsellino/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Contains the data of a specific coin
class Coin {
  final String denom;
  final double amount;

  Coin({
    @required this.denom,
    @required this.amount,
  })  : assert(denom != null),
        assert(amount != null);

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      amount: double.parse(json["amount"]) * TOKEN_MULTIPLICATION_FACTOR,
      denom: json["denom"],
    );
  }
}
