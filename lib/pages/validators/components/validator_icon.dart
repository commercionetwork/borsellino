import 'package:borsellino/models/models.dart';
import 'package:flutter/material.dart';

/// Represents the Widget used to display the image of a validator.
class ValidatorIcon extends StatelessWidget {
  final Validator _validator;

  ValidatorIcon(this._validator);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://commercio.network/wp-content/uploads/2018/04/logo_commercio_300-150x150.png",
      width: 50,
    );
  }
}
