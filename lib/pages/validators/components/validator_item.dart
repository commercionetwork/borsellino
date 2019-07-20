import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:flutter/material.dart';

import 'components.dart';
import 'validator_info.dart';

/// Stateless widget representing a single validator entry on the
/// list of all validators
class ValidatorItem extends StatelessWidget {
  final Validator _validator;

  ValidatorItem(this._validator);

  void _viewDetails(BuildContext context) {
    Navigator.pushNamed(
      context,
      ValidatorDetailsPage.routeName,
      arguments: ValidatorDetailsArguments(validator: _validator),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: InkWell(
          onTap: () => _viewDetails(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ValidatorIcon(
                  key: ValueKey(_validator.identity),
                  validator: _validator,
                ),
                const SizedBox(width: 8),
                ValidatorInfo(_validator),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
