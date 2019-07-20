import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/validator_details/components/validator_coin_info_item.dart';
import 'package:flutter/material.dart';


class CoinInfoRow extends StatelessWidget {
  final String descriptionText;
  final String infoText;

  CoinInfoRow({this.descriptionText, this.infoText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ValidatorCoinInfo(
            text: descriptionText, weight: FontWeight.bold),
        ValidatorCoinInfo(
            text: infoText, weight: FontWeight.normal)
      ],
    );
  }
}
