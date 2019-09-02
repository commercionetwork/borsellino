import 'package:borsellino/models/models.dart';
import 'package:sacco/sacco.dart';

class GenerateAccountArguments {
  final List<String> mnemonic;
  final Account account;
  final NetworkInfo networkInfo;

  GenerateAccountArguments(this.mnemonic, this.account, this.networkInfo)
      : assert((mnemonic != null && mnemonic.isNotEmpty) || account != null),
        assert(networkInfo != null);
}
