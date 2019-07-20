import 'package:borsellino/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'std_fee.g.dart';

@JsonSerializable()
class StdFee {
  final List<StdCoin> amount;
  final String gas;

  StdFee({
    @required this.amount,
    @required this.gas,
  }) : assert(gas != null);

  factory StdFee.fromJson(Map<String, dynamic> json) => _$StdFeeFromJson(json);

  Map<String, dynamic> toJson() => _$StdFeeToJson(this);
}
