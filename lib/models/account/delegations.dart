import 'package:meta/meta.dart';

class DelegationData {
  final String validator;
  final double shares;

  DelegationData({
    @required this.validator,
    @required this.shares,
  })  : assert(validator != null),
        assert(shares != null);

  Map<String, dynamic> toJson() =>
      {
        'validator': this.validator,
        'shares': this.shares.toString(),
      };

  factory DelegationData.fromJson(Map<String, dynamic> json) =>
      DelegationData(
        validator: json['validator'] as String,
        shares: double.parse(json['shares'] as String),
      );
}

class UnbondingDelegation {
  final String validator;
  final double balance;

  UnbondingDelegation({
    @required this.validator,
    @required this.balance,
  })  : assert(validator != null),
        assert(balance != null);

  Map<String, dynamic> toJson() =>
      {
        'validator': this.validator,
        'balance': this.balance.toString(),
      };

  factory UnbondingDelegation.fromJson(Map<String, dynamic> json) =>
      UnbondingDelegation(
        validator: json['validator'] as String,
        balance: double.parse(json['balance'] as String),
      );
}
