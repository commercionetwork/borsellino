import 'package:bloc/bloc.dart';
import 'package:borsellino/app.dart';
import 'package:borsellino/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

void main() {
  // For desktop applications
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  // Setup the bloc delegate so we can see the transitions printed correctly
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // Build and start the application
  runApp(BorsellinoApp());
}
