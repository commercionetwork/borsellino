import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:borsellino/bloc/generate_mnemonic/generate_mnemonic_state.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/repository/repositories.dart';
import './bloc.dart';

class GenerateMnemonicBloc
    extends Bloc<GenerateMnemonicEvent, GenerateMnemonicState> {

  final MnemonicRepository mnemonicRepository = BorsellinoInjector.get();

  @override
  GenerateMnemonicState get initialState => InitialGenerateMnemonicState();

  @override
  Stream<GenerateMnemonicState> mapEventToState(
    GenerateMnemonicEvent event,
  ) async* {
    if (event is GenerateNewMnemonicEvent) {
      final mnemonic = await mnemonicRepository.generateRandomMnemonic();
      yield MnemonicGeneratedState(mnemonic);
    }
  }
}
