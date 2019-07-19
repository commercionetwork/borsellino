import 'package:borsellino/bloc/import_mnemonic/bloc.dart';
import 'package:borsellino/bloc/import_mnemonic/import_mnemonic_bloc.dart';
import 'package:flutter/material.dart';

AppBar appBar(ImportMnemonicBloc bloc) {
  return AppBar(
    title: Text("Import mnemonic"),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          bloc.dispatch(ClearMnemonicEvent());
        },
      )
    ],
  );
}