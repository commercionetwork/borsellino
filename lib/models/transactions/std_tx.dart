import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/transactions/std_signature.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

@JsonSerializable()
class StdTx {
  @JsonKey(name: "msg")
  final List<StdMsg> messages;

  final List<StdSignature> signatures;

  final StdFee fee;
  final String memo;

  StdTx({
    @required this.messages,
    @required this.signatures,
    @required this.fee,
    @required this.memo,
  })  : assert(messages != null),
        assert(signatures != null),
        assert(fee != null);

  Map<String, dynamic> toJson() => {
        'msg': this.messages.map((message) => message.toJson()).toList(),
        'signatures': this.signatures.map((signature) => signature.toJson()).toList(),
        'fee': this.fee.toJson(),
        'memo': this.memo,
      };
}
