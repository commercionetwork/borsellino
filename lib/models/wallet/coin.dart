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
}
