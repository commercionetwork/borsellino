import 'package:borsellino/theme/sizes.dart';
import 'package:flutter/material.dart';

/// Represents the form fee input section.
class FormFeeItem extends StatefulWidget {
  final List<double> fees;
  final int initialPosition;
  final ValueChanged<double> onFeeSelected;

  FormFeeItem({
    Key key,
    @required this.fees,
    @required this.initialPosition,
    @required this.onFeeSelected,
  }) : super(key: key);

  @override
  _FormFeeItemState createState() => _FormFeeItemState();
}

class _FormFeeItemState extends State<FormFeeItem> {
  int radioIndex = -1;

  @override
  void initState() {
    radioIndex = widget.initialPosition;
    super.initState();
  }

  /// Handles the selection of the radio button at the [index] position.
  void _handleRadioValueChange(int index) {
    // Update the state
    setState(() {
      radioIndex = index;
    });

    // Tell the listener which fee has been selected
    widget.onFeeSelected(widget.fees[index]);
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = TextStyle(
      fontSize: FontSize.MEDIUM,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColorDark,
    );

    return Column(
      children: <Widget>[
        Text('Fee Amount', style: titleTextStyle),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.fees
              .asMap()
              .map((index, feeValue) {
                return MapEntry(index, _buildFeeEntry(index, feeValue));
              })
              .values
              .toList(),
        )
      ],
    );
  }

  /// Given the fee at index [index] and with value [feeValue], returns
  /// a widget that allows it to be selected.
  Widget _buildFeeEntry(int index, double feeValue) {
    final widget = Row(
      children: <Widget>[
        Radio(
          value: index,
          groupValue: radioIndex,
          onChanged: _handleRadioValueChange,
        ),
        Text(feeValue.toStringAsFixed(6)),
      ],
    );
    return widget;
  }
}
