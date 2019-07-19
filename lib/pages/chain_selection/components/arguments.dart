import 'package:borsellino/models/models.dart';

/// Contains the data that can be passed to the
/// ChainSelectionPage
class ChainSelectionArguments {
  /// If not null, tells that upon selecting the chain, a new
  /// account should be created from this mnemonic
  final List<String> mnemonic;

  /// If not null, tells that upon selecting a chain, a new
  /// account should be created starting from this one
  final Account account;

  ChainSelectionArguments({
    this.mnemonic,
    this.account,
  }) : assert(mnemonic != null || account != null);
}
