import 'package:borsellino/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

@immutable
abstract class AccountGenerationEvent extends Equatable {
  AccountGenerationEvent([List props = const []]) : super(props);
}

class GenerateAccountEvent extends AccountGenerationEvent {
  final List<String> mnemonic;
  final Account account;
  final NetworkInfo networkInfo;

  GenerateAccountEvent(
    this.mnemonic,
    this.account,
    this.networkInfo,
  )   : assert((mnemonic != null && mnemonic.isNotEmpty) || account != null),
        assert(networkInfo != null),
        super([mnemonic, account, networkInfo]);
}
