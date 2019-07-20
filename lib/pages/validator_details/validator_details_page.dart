import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/pages/validator_details/components/validator_coin_info_row_item.dart';
import 'package:borsellino/pages/validator_details/components/validator_description_item.dart';
import 'package:borsellino/pages/validator_details/components/validator_main_info_item.dart';
import 'package:flutter/material.dart';

class ValidatorDetailsPage extends StatelessWidget {
  static const routeName = "/validatorDetails";

  @override
  Widget build(BuildContext context) {
    const hSeparator = SizedBox(height: 10);
    const rowSeparator = SizedBox(height: 6);

    return Scaffold(
      appBar: AppBar(title: Text(APP_NAME),),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          color: Theme.of(context).primaryColorLight,
          elevation: 7,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                ValidatorMainInfo(
                  imgUrl: DEFAULT_CHAIN_IMAGE_URL,
                  validatorName: 'ValidatorName',
                  validatorUrl: 'https://validator.site.com',
                ),
                hSeparator,
                ValidatorDescription(
                    'Questa è la maxi-storia di come la mia vita cambiata, '
                    'capovolta, sottosopra sia finita seduto su due piedi'
                    ' qui con te ti parlerò di Willy superfico di Bel Air.'),
                Divider(color: Colors.black54),
                SizedBox(height: 8),
                CoinInfoRow(descriptionText: 'Total Bonded', infoText: '10,000,000.000000'),
                rowSeparator,
                CoinInfoRow(descriptionText: 'Self Bonded Rate', infoText: "100%",),
                rowSeparator,
                CoinInfoRow(descriptionText: 'Average Yield', infoText: "100%",),
                rowSeparator,
                CoinInfoRow(descriptionText: 'Commission Rate', infoText: "100%")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
