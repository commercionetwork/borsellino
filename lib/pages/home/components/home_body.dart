import 'package:borsellino/blocprov/blocproviders.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/validators/validator_filter.dart';
import 'package:flutter/material.dart';

// Body of the Home page
TabBarView homeBody(TabController controller) {
  return TabBarView(
    controller: controller,
    children: <Widget>[
      validatorBlockProvider(ValidatorFilter(status: ValidatorStatus.ACTIVE)),
      validatorBlockProvider(ValidatorFilter(status: ValidatorStatus.INACTIVE)),
    ],
  );
}
