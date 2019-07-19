import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/validators/components/validator_info.dart';
import 'package:flutter/material.dart';

import 'components.dart';

/// Stateless widget representing a single validator entry on the
/// list of all validators
class ValidatorItem extends StatelessWidget {
  final Validator _validator;

  ValidatorItem(this._validator);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: InkWell(
          onTap: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Not implemented yet'),
            ));
          },
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
