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

enum FormStatus { VALID, INVALID, UNKNOWN }

class _SendCoinsFormState extends State<SendCoinsForm> {
  FormStatus _formStatus = FormStatus.UNKNOWN;

  // Fees to be displayed
  final _initialFeeIndex = 1;
  final _fees = [0.000001, 0.000250, 0.002500];

  // User input data
  String _recipient = "";
  String _amount = "";
  double _fee = 0.0;

  @override
  void initState() {
    _fee = _fees[_initialFeeIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormItem(
                fieldDescription: 'Recipient',
                fieldLabel: 'Recipient Address',
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _recipient = value;
                  });
                },
              ),
              SizedBox(height: 16),
              FormItem(
                fieldDescription: 'Amount',
                fieldLabel: 'Coins amount',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _amount = value;
                },
              ),
              SizedBox(height: 16),
              FormFeeItem(
                fees: _fees,
                initialPosition: _initialFeeIndex,
                onFeeSelected: (value) {
                  setState(() {
                    _fee = value;
                  });
                },
              ),
              SizedBox(height: 32),
              FormSubmitItem(
                formState: _formStatus,
                onPressed: _validateForm,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validateForm() {
    bool isValid = true;

    isValid &= _recipient.trim().isNotEmpty;

    // Check amount
    isValid &= _amount.trim().isNotEmpty && double.parse(_amount) > 0.0;

    // Check fee
    isValid &= _fee > 0.0;

    print(isValid);

    setState(() {
      _formStatus = isValid ? FormStatus.VALID : FormStatus.INVALID;
    });
  }
}
