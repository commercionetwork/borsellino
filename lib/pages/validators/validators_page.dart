import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/bloc/validators/validators_bloc.dart';
import 'package:borsellino/bloc/validators/validators_event.dart';
import 'package:borsellino/bloc/validators/validators_state.dart';
import 'package:borsellino/models/validators/validator_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/validator_item.dart';


/// Page containing the list of validators satisfying a given filter.
/// It relies on a ValidatorBloc in order to get the current state and
/// dispatch events.
class ValidatorsPage extends StatelessWidget {

  final ValidatorFilter _filter;

  ValidatorsPage(this._filter);

  @override
  Widget build(BuildContext context) {
    // Get the bloc
    final validatorsBloc = BlocProvider.of<ValidatorsBloc>(context);

    // Emit the loading event
    validatorsBloc.dispatch(LoadValidatorsEvent(_filter));

    return Scaffold(
      body: Center(
        child: BlocBuilder(
          bloc: validatorsBloc,
          builder: (_, ValidatorsState state) {
            if (state is EmptyValidatorsState) {
              return Center(child: Text("No validators available"));
            }

            if (state is LoadingValidatorsState) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ValidatorsLoadedState) {
              return ListView.builder(
                  itemCount: state.validators.length,
                  itemBuilder: (_, index) {
                    return ValidatorItem(state.validators[index]);
                  });
            }

            return Center(child: Text("Error while loading validators"));
          },
        ),
      ),
    );
  }
}
