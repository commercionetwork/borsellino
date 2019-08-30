import 'package:meta/meta.dart';

class DelegationData {
  final String validator;
  final double shares;

  DelegationData({
    @required this.validator,
    @required this.shares,
  })  : assert(validator != null),
        assert(shares != null);
}

class UnbondingDelegation {
  final String validator;
  final double balance;

  UnbondingDelegation({
    @required this.validator,
    @required this.balance,
  })  : assert(validator != null),
        assert(balance != null);
}
