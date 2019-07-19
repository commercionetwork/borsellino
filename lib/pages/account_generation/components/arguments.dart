import 'package:borsellino/models/models.dart';
import 'package:meta/meta.dart';

/// Contains the arguments that must be passed to the AccountGenerationPage
class AccountGenerationArgs {
  final List<String> mnemonic;
  final ChainInfo chainInfo;

  AccountGenerationArgs({
    @required this.mnemonic,
    @required this.chainInfo,
  })  : assert(mnemonic != null),
        assert(chainInfo != null);
}
