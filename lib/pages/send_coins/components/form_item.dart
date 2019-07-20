import 'package:borsellino/theme/sizes.dart';
import 'package:flutter/material.dart';

/// Represents a generic form text input.
class FormItem extends StatelessWidget {
  final String fieldDescription;
  final String fieldLabel;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  FormItem({
    @required this.fieldDescription,
    @required this.fieldLabel,
    @required this.keyboardType,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = TextStyle(
      fontSize: FontSize.MEDIUM,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColorDark,
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Text(fieldDescription, style: titleTextStyle),
          TextFormField(
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: fieldLabel,
              alignLabelWithHint: true,
            ),
            keyboardType: keyboardType,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
