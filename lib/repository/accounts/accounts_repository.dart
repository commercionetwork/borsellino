import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/sources.dart';

/// Repository to be used when dealing with accounts.
class AccountsRepository {
  final AccountsSource accountsSource;

  AccountsRepository(this.accountsSource);

  /// Creates a new account based on the given [mnemonic] and for the given
  /// [chain].
  Future<Account> createAccount(List<String> mnemonic, ChainInfo chain) async {
    // Store the account data
    return await accountsSource.createAndStoreAccount(mnemonic, chain);
  }

  /// Creates a new Account starting from the given [account]. The new one
  /// will be used in order to interact with the given [chain].
  Future<Account> convertAccount(Account account, ChainInfo chain) async {
    return await accountsSource.convertAndStoreAccount(account, chain);
  }

  /// Saves the given [account] as the current account
  /// and returns its details once done.
  Future<Account> setAccountAsCurrent(Account account) async {
    await accountsSource.saveAccountAsCurrent(account);
    return account;
  }

  /// Lists all the saved accounts.
  Future<List<Account>> listAccounts() async {
    return await accountsSource.listAccounts();
  }

  /// Returns the current account, or null if no current account is set.
  Future<Account> getCurrentAccount() async {
    return await accountsSource.getCurrentAccount();
  }

  /// Allows to logout setting the current account as null.
  Future<void> logout() async {
    return await accountsSource.logout();
  }
}
