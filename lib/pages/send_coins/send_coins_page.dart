import 'package:borsellino/pages/send_coins/components/send_coins_form.dart';
import 'package:flutter/material.dart';

/// Page that is shown to the user when he wants to send some amount of
/// token to another user.
class SendCoinsPage extends StatefulWidget {
  @override
  _SendCoinsPageState createState() => _SendCoinsPageState();
}

class _SendCoinsPageState extends State<SendCoinsPage> {
  @override
  Widget build(BuildContext context) {
    return SendCoinsForm();
  }
}
