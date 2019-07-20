import 'package:borsellino/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'std_signature.g.dart';

@JsonSerializable()
class StdSignature {
  @JsonKey(name: 'chain_id')
  final String chainId;

  @JsonKey(name: 'account_number')
  final String accountNumber;

  final String sequence;
  final String memo;
  final StdFee fee;
  final List<Map<String, dynamic>> msgs;

  StdSignature({
    @required this.chainId,
    @required this.accountNumber,
    @required this.sequence,
    @required this.memo,
    @required this.fee,
    @required this.msgs,
  })  : assert(chainId != null),
        assert(accountNumber != null),
        assert(sequence != null),
        assert(msgs != null);

  factory StdSignature.fromJson(Map<String, dynamic> json) =>
      _$StdSignatureFromJson(json);

  Map<String, dynamic> toJson() => _$StdSignatureToJson(this);
}
