import 'package:borsellino/models/validators/validator.dart';
import 'package:flutter/cupertino.dart';

class ValidatorDetailsArguments {
  final Validator validator;

  ValidatorDetailsArguments({
    @required this.validator,
  }) : assert(validator != null);
}
