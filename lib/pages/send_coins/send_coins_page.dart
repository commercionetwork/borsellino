import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/pages/send_coins/components/send_coins_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Page that is shown to the user when he wants to send some amount of
/// token to another user.
class SendCoinsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SendCoinsBloc bloc = BlocProvider.of(context);

    return BlocBuilder(
      bloc: bloc,
      builder: (_, SendCoinsState state) {
        return Container(
          child: SendCoinsForm(),
        );
      },
    );
  }
}

