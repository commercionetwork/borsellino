import 'dart:convert';
import 'dart:typed_data';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/transactions/map_sorter.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/export.dart';

/// Contains the data that are obtained from the signature or an
/// [StdSignature] object.
class SignatureData {
  final String base64Signature;
  final ECPublicKey publicKey;

  SignatureData({this.base64Signature, this.publicKey});
}