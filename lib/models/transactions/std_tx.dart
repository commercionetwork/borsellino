import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/transactions/std_signature.dart';
import 'package:json_annotation/json_annotation.dart';

part 'std_tx.g.dart';

@JsonSerializable()
class StdTx {
  @JsonKey(name: "msg")
  final List<StdMsg> messages;

  final List<StdSignature> signatures;

  final StdFee fee;
  final String memo;

  StdTx({this.messages, this.signatures, this.fee, this.memo})
      : assert(messages != null),
        assert(signatures != null),
        assert(fee != null);

  factory StdTx.fromJson(Map<String, dynamic> json) =>
      _$StdTxFromJson(json);

  Map<String, dynamic> toJson() => _$StdTxToJson(this);
}
