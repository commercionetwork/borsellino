import 'package:borsellino/pages/send_coins/components/form_fee_item.dart';
import 'package:borsellino/pages/send_coins/components/form_item.dart';
import 'package:borsellino/pages/send_coins/components/form_submit_item.dart';
import 'package:flutter/material.dart';

/// Form that allows the user to send a specified amount of token
/// to another user.
class SendCoinsForm extends StatefulWidget {
  @override
  _SendCoinsFormState createState() => _SendCoinsFormState();
}

class _SendCoinsFormState extends State<SendCoinsForm> {
  final _formKey = GlobalKey<FormState>();

  int _radioValue = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormItem(
                fieldDescription: 'Recipient',
                fieldLabel: 'Recipient Address',
                keyboardType: TextInputType.text,
              ),
              FormItem(
                fieldDescription: 'Amount',
                fieldLabel: 'Coins amount',
                keyboardType: TextInputType.number,
              ),
              FormFeeItem(_radioValue),
              FormSubmitItem(_formKey)
            ],
          ),
        ),
      ),
    );
  }
}
