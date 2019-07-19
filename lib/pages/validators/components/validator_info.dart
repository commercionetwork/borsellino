import 'package:basic_utils/basic_utils.dart';
import 'package:borsellino/models/models.dart';
import 'package:flutter/material.dart';

/// Contains the textual information of a single validator inside the
/// validators list.
class ValidatorInfo extends StatelessWidget {
  final Validator _validator;

  ValidatorInfo(this._validator);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  StringUtils.capitalize(_validator.name),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Voting power"),
              Text("${_validator.tokens.toStringAsFixed(6)}"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Average yield"),
              Text("${_validator.yieldPercentage.toStringAsFixed(2)}%"),
            ],
          )
        ],
      ),
    );
  }
}
