import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/sources.dart';

/// Repository that must be used when dealing with wallets.
class WalletRepository {
  final WalletSource walletSource;

  WalletRepository(this.walletSource) : assert(walletSource != null);

  /// Allows to return the current wallet instance.
  Future<Wallet> getCurrentWallet() async {
    return await walletSource.getCurrentWallet();
  }
}
