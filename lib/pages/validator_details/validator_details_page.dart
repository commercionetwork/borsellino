import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/validator_details/components/arguments.dart';
import 'package:borsellino/pages/validator_details/components/validator_coin_info_row_item.dart';
import 'package:borsellino/pages/validator_details/components/validator_description_item.dart';
import 'package:borsellino/pages/validator_details/components/validator_main_info_item.dart';
import 'package:flutter/material.dart';

export 'components/arguments.dart';

class ValidatorDetailsPage extends StatelessWidget {
  static const routeName = "/validatorDetails";

  @override
  Widget build(BuildContext context) {
    final ValidatorDetailsArguments args =
        ModalRoute.of(context).settings.arguments;

    final Validator validator = args.validator;

    const hSeparator = SizedBox(height: 10);
    const rowSeparator = SizedBox(height: 6);

    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          color: Theme.of(context).primaryColorLight,
          elevation: 7,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                ValidatorMainInfo(validator: validator),
                hSeparator,
                ValidatorDescription(validator.description),
                Divider(color: Colors.black54),
                SizedBox(height: 8),
                CoinInfoRow(
                  descriptionText: 'Total Bonded',
                  infoText: validator.tokens.toStringAsFixed(6),
                ),
                rowSeparator,
//                CoinInfoRow(
//                  descriptionText: 'Self Bonded Rate',
//                  infoText: "100%",
//                ),
                rowSeparator,
                CoinInfoRow(
                  descriptionText: 'Average Yield',
                  infoText: "${validator.yieldPercentage.toStringAsFixed(2)}%",
                ),
                rowSeparator,
                CoinInfoRow(
                  descriptionText: 'Commission Rate',
                  infoText: "${validator.commissionRate.toStringAsFixed(2)}%",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
