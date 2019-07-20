import 'package:flutter/material.dart';
import 'package:borsellino/theme/sizes.dart';


class ValidatorMainInfo extends StatelessWidget {
  final imgUrl;
  final validatorName;
  final validatorUrl;

  ValidatorMainInfo({this.imgUrl, this.validatorName, this.validatorUrl});


  @override
  Widget build(BuildContext context) {
    const wSeparator = SizedBox(width: 8);
    const hSeparator = SizedBox(height: 3);

    return Row(
      children: <Widget>[
        Image.network(imgUrl, width: 50),
        wSeparator,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              validatorName,
              style: TextStyle(
                  fontSize: FontSize.MEDIUM, color: Colors.white),
            ),
            hSeparator,
            Text(
              validatorUrl,
              style: TextStyle(
                  fontSize: FontSize.SMALL, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}
