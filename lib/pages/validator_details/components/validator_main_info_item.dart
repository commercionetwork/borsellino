import 'package:basic_utils/basic_utils.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/validators/components/validator_icon.dart';
import 'package:flutter/material.dart';
import 'package:borsellino/theme/sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class ValidatorMainInfo extends StatelessWidget {
  final Validator validator;

  ValidatorMainInfo({this.validator});

  @override
  Widget build(BuildContext context) {
    const wSeparator = SizedBox(width: 16);
    const hSeparator = SizedBox(height: 8);

    final nameTextStyle = TextStyle(
        fontSize: FontSize.MEDIUM, color: Theme.of(context).primaryColorDark);

    final websiteTextStyle = TextStyle(
      fontSize: FontSize.SMALL,
      color: Theme.of(context).accentColor,
      decoration: TextDecoration.underline,
    );

    return Row(
      children: <Widget>[
        ValidatorIcon(key: ValueKey(validator.name), validator: validator),
        wSeparator,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(StringUtils.capitalize(validator.name), style: nameTextStyle),
            hSeparator,
            GestureDetector(
              child: Text(validator.website, style: websiteTextStyle),
              onTap: () {
                _openLink(validator.website);
              },
            ),
          ],
        ),
      ],
    );
  }

  void _openLink(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
