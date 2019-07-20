import 'package:borsellino/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'msg_send.g.dart';

@JsonSerializable()
class MsgSend {
  @JsonKey(name: "from_address")
  final String fromAddress;

  @JsonKey(name: "to_address")
  final String toAddress;

  final List<StdCoin> amount;

  MsgSend({
    this.fromAddress,
    this.toAddress,
    this.amount,
  })  : assert(fromAddress != null),
        assert(toAddress != null),
        assert(amount != null);

  factory MsgSend.fromJson(Map<String, dynamic> json) =>
      _$MsgSendFromJson(json);

  Map<String, dynamic> toJson() => _$MsgSendToJson(this);
}
