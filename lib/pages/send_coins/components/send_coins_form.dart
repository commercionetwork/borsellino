import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/bloc/send_coins/send_coins_event.dart';
import 'package:borsellino/bloc/send_coins/send_coins_state.dart';
import 'package:borsellino/pages/send_coins/components/coins_sent_widget.dart';
import 'package:borsellino/pages/send_coins/components/form_fee_item.dart';
import 'package:borsellino/pages/send_coins/components/form_item.dart';
import 'package:borsellino/pages/send_coins/components/form_submit_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sending_coins_error_widget.dart';
import 'sending_coins_widget.dart';

/// Form that allows the user to send a specified amount of token
/// to another user.
class SendCoinsForm extends StatelessWidget {
  FormStatus _formStatus = FormStatus.UNKNOWN;

  // Fees to be displayed
  final _fees = [0.000001, 0.000250, 0.002500];

  @override
  Widget build(BuildContext context) {
    final SendCoinsBloc bloc = BlocProvider.of(context);

    const separator = SizedBox(height: 16);

    // TODO: Allow the user to select a coin. If no coins are available show an error
    return BlocBuilder(
      bloc: bloc,
      builder: (_, SendCoinsState state) {
        // Check if it's the first start of the page, update the fee accordingly
        if (state is InitialSendCoinsState && state.sendData.feeAmount == 0.0) {
          final fee = _fees[1];
          bloc.dispatch(SendCoinsParamsChangedEvent(
            state.sendData.copy(feeAmount: fee),
          ));
        }

        // Show the loading bar
        if (state is SendingCoinsState) {
          return SendingCoinsWidget();
        }

        // Show the successful screen
        if (state is CoinsSentState) {
          return CoinsSentWidget(txHash: state.txHash);
        }

        // Validate the data
        if (state is ValidSendCoinDataState) {
          bloc.dispatch(SendCoinsRequestedEvent(state.sendData));
        }

        // On error, get the state back as it was
        if (state is ErrorSendingCoinsState) {
          return SendingCoinsErrorWidget();
        }

        const errorStyle = TextStyle(color: Colors.red);

        return Container(
          padding: EdgeInsets.all(16),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _recipientField(bloc),
                  separator,
                  _amountField(bloc),
                  separator,
                  _feesField(bloc),
                  separator,
                  separator,
                  if (!(state is SendingCoinsState)) _submitButton(bloc),
                  if (state is InvalidSendCoinDataState)
                    Text(
                      "Invalid data. Please check and try again.",
                      style: errorStyle,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  FormSubmitItem _submitButton(SendCoinsBloc bloc) {
    return FormSubmitItem(
      formState: _formStatus,
      onPressed: () {
        // Validate the form
        bloc.dispatch(ValidateDataEvent(bloc.currentState.sendData));
      },
    );
  }

  FormFeeItem _feesField(SendCoinsBloc bloc) {
    int feeIndex =
        _fees.indexWhere((fee) => fee == bloc.currentState.sendData.feeAmount);
    if (feeIndex < 0) {
      feeIndex = 1;
    }

    return FormFeeItem(
      fees: _fees,
      initialPosition: feeIndex,
      onFeeSelected: (value) {
        final data = bloc.currentState.sendData.copy(feeAmount: value);
        bloc.dispatch(SendCoinsParamsChangedEvent(data));
      },
    );
  }

  FormItem _amountField(SendCoinsBloc bloc) {
    final amount = bloc.currentState.sendData.amount;

    String initialValue = "";
    if (amount > 0.0) {
      initialValue = amount.toString();
    }

    return FormItem(
      fieldDescription: 'Amount',
      fieldLabel: 'Coins amount',
      value: initialValue,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        final data =
            bloc.currentState.sendData.copy(amount: double.parse(value));
        bloc.dispatch(SendCoinsParamsChangedEvent(data));
      },
    );
  }

  FormItem _recipientField(SendCoinsBloc bloc) {
    return FormItem(
      fieldDescription: 'Recipient',
      fieldLabel: 'Recipient Address',
      value: bloc.currentState.sendData.recipient,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        final data = bloc.currentState.sendData.copy(recipient: value);
        bloc.dispatch(SendCoinsParamsChangedEvent(data));
      },
    );
  }
}

enum FormStatus { VALID, INVALID, UNKNOWN }
