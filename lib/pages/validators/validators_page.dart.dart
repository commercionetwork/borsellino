import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/bloc/validators/validators_bloc.dart';
import 'package:borsellino/bloc/validators/validators_event.dart';
import 'package:borsellino/bloc/validators/validators_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidatorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the bloc
    final validatorsBloc = BlocProvider.of<ValidatorsBloc>(context);

    // Emit the loading event
    validatorsBloc.dispatch(LoadValidatorsEvent());

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
                    final validator = state.validators[index];

                    return Text("${validator.name} - ${validator.address}");
                  });
            }

            return Center(child: Text("Error while loading validators"));
          },
        ),
      ),
    );
  }
}
