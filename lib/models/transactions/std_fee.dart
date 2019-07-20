import 'package:borsellino/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

@JsonSerializable()
class StdFee {
  final String gas;

  @JsonKey(includeIfNull: true)
  final List<StdCoin> amount;

  StdFee({
    @required this.amount,
    @required this.gas,
  }) : assert(gas != null);

  Map<String, dynamic> toJson() => {
    'gas': this.gas,
    'amount': this.amount.map((coin) => coin.toJson()).toList(),
  };
}
