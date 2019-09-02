import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/sources.dart';
import 'package:sacco/sacco.dart';

/// Repository that must be used when dealing with wallets.
class AccountRepository {
  final AccountSource accountSource;

  AccountRepository(this.accountSource) : assert(accountSource != null);

  /// Returns a Stream emitting new account values as they are created.
  Stream<Account> getAccountStream() {
    return accountSource.getCurrentAccountStream();
  }

  /// Creates a new account based on the given [mnemonic] and for the given
  /// [chain].
  Future<Account> createAccount(List<String> mnemonic, NetworkInfo chain) {
    return accountSource.createAndStoreAccount(mnemonic, chain);
  }

  /// Creates a new Account starting from the given [account]. The new one
  /// will be used in order to interact with the given [chain].
  Future<Account> convertAccount(Account account, NetworkInfo chain) {
    return accountSource.convertAndStoreAccount(account, chain);
  }

  /// Saves the given [account] as the current account
  /// and returns its details once done.
  Future<Account> setAccountAsCurrent(Account account) {
    return accountSource.saveAccountAsCurrent(account);
  }

  /// Returns the current account, or null if no current account is set.
  Future<Account> getCurrentAccount({bool forceRefresh = false}) {
    return accountSource.getCurrentAccount(forceRefresh: forceRefresh);
  }

  /// Returns true iff there is a current account set.
  Future<bool> hasCurrentAccount() {
    return accountSource.hasCurrentAccount();
  }

  /// Returns the list of all the wallets securely stored into the device.
  Future<List<Account>> listAccounts() {
    return accountSource.listAccounts();
  }

  /// Allows to logout setting the current wallet as null.
  Future<void> logout() {
    return accountSource.logout();
  }
}
