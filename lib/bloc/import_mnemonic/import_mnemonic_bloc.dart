import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:borsellino/bloc/import_mnemonic/import_mnemonic_event.dart';
import './bloc.dart';

class ImportMnemonicBloc
    extends Bloc<ImportMnemonicEvent, ImportMnemonicState> {
  @override
  ImportMnemonicState get initialState => EmptyMnemonicState();

  @override
  Stream<ImportMnemonicState> mapEventToState(
    ImportMnemonicEvent event,
  ) async* {
    if (event is ClearMnemonicEvent) {
      yield EmptyMnemonicState();
    }

    if (event is CurrentMnemonicChangedEvent) {
      final mnemonic = event.mnemonic
          .split(RegExp("\\s+"))
          .takeWhile((value) => value.isNotEmpty)
          .toList();

      if (mnemonic.length == 0) {
        yield EmptyMnemonicState();
      } else if (mnemonic.length % 12 == 0 ||
          mnemonic.length % 16 == 0 ||
          mnemonic.length % 24 == 0) {
        yield ValidMnemonicLengthState(mnemonic);
      } else {
        yield InvalidMnemonicLengthState(mnemonic);
      }
    }
  }
}
