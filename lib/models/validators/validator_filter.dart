import 'package:borsellino/models/models.dart';
import 'package:flutter/cupertino.dart';

/// Represents a filter that can be applied to list of validators.
class ValidatorFilter {
  final ValidatorStatus status;

  ValidatorFilter({@required this.status}) : assert(status != null);
}
