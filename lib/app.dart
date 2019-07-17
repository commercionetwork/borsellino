import 'package:borsellino/bloc/validators/validators_bloc.dart';
import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:borsellino/repository/repositories.dart';
import 'package:borsellino/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BorsellinoApp extends StatelessWidget {
  final ValidatorsRepository repository;

  BorsellinoApp({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => ValidatorsBloc(repository: repository),
      child: MaterialApp(
        title: APP_NAME,
        theme: borsellinoTheme(),
        home: ValidatorsPage(),
      ),
    );
  }
}


