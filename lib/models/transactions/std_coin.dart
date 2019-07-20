import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'std_coin.g.dart';

/// Contains the data of a specific coin
@JsonSerializable()
class StdCoin {
  final String denom;
  final double amount;

  StdCoin({
    @required this.denom,
    @required this.amount,
  })  : assert(denom != null),
        assert(amount != null);

  factory StdCoin.fromJson(Map<String, dynamic> json) => StdCoin(
        denom: json['denom'] as String,
        amount: double.parse(json['amount']),
      );

  Map<String, dynamic> toJson() => _$StdCoinToJson(this);
}
