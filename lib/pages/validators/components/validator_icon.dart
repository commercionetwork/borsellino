import 'dart:async';

import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/repository/repositories.dart';
import 'package:flutter/material.dart';

/// Represents the Widget used to display the image of a validator.
class ValidatorIcon extends StatefulWidget {
  final Validator validator;

  ValidatorIcon({
    @required Key key,
    @required this.validator,
  })  : assert(validator != null),
        super(key: key);

  @override
  _ValidatorIconState createState() => _ValidatorIconState();
}

class _ValidatorIconState extends State<ValidatorIcon> {
  var validatorIcon;
  final ValidatorsRepository repository = BorsellinoInjector.get();

  StreamSubscription<void> _future;

  @override
  void initState() {
    super.initState();
    _future = repository
        .getValidatorImageUrl(widget.validator)
        .asStream()
        .listen((imageUrl) => {
              setState(() {
                validatorIcon = imageUrl;
              })
            });
  }

  @override
  void dispose() {
    super.dispose();
    _future?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        validatorIcon ??
            // TODO: Replace this with an asset
            "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Noun_Project_question_mark_icon_1101884_cc.svg/1024px-Noun_Project_question_mark_icon_1101884_cc.svg.png",
        width: 50,
      ),
    );
  }
}
