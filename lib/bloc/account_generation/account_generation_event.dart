import 'package:borsellino/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AccountGenerationEvent extends Equatable {
  AccountGenerationEvent([List props = const []]) : super(props);
}

class GenerateAccountEvent extends AccountGenerationEvent {
  final List<String> mnemonic;
  final ChainInfo chainInfo;

  GenerateAccountEvent({
    @required this.mnemonic,
    @required this.chainInfo,
  })  : assert(mnemonic != null),
        assert(chainInfo != null),
        super([mnemonic, chainInfo]);
}
