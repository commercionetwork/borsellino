import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/sources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:hex/hex.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account_helper.dart';

/// Source that must be used when dealing with accounts.
class AccountsSource {
  // Current account key
  static const _currentAccountKey = "AccountSource#currentAccount";

  final ChainsSource chainsSource;
  final FlutterSecureStorage secureStorage;
  final AccountHelper accountHelper;

  AccountsSource({
    @required this.chainsSource,
    @required this.secureStorage,
    @required this.accountHelper,
  })  : assert(chainsSource != null),
        assert(secureStorage != null),
        assert(accountHelper != null);

  /// Generates and stores an account associated to the
  /// given [mnemonic] for the given [chain].
  /// Returns the account one it has been stored.
  Future<Account> createAndStoreAccount(
    List<String> mnemonic,
    ChainInfo chain,
  ) async {
    // Generate the private key
    final privateKey = await accountHelper.generatePrivateKey(mnemonic);

    // Generate the account
    final account = await accountHelper.generateAccount(privateKey, chain);

    // Store the private key into the safe storage
    secureStorage.write(
      key: account.address,
      value: HEX.encode(privateKey),
    );

    // Save the association between the address and the chain
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(account.address, chain.id);

    // Return the created account
    return account;
  }

  /// Allows to set the given [account] as the currently used account.
  Future<void> saveAccountAsCurrent(Account account) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_currentAccountKey, account.address);
  }

  /// Returns the list of all the accounts securely stored into the device.
  Future<List<Account>> listAccounts() async {
    // List all the private keys
    final privateKeys = await secureStorage.readAll();

    // Get a reference to the SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Define the accounts
    final List<Account> accounts = List();

    privateKeys.forEach((address, privateKey) async {
      // Get the chain id from the preferences
      final chain = prefs.getString(address);

      // Get the chain data from the source
      final chainData = await chainsSource.getChainById(chain);

      // Decode the private key into bytes
      final privateKeyBytes = HEX.decode(privateKey);

      // Re-generate the account data
      final account = await accountHelper.generateAccount(
        privateKeyBytes,
        chainData,
      );

      // Add the generated account into the list
      accounts.add(account);
    });

    // Return the accounts list
    return accounts;
  }

  /// Returns the current account, or null if no account could be found.
  Future<Account> getCurrentAccount() async {
    // Get the current account address
    final prefs = await SharedPreferences.getInstance();
    final accountAddress = prefs.getString(_currentAccountKey);

    if (accountAddress == null) {
      // No current account set, return null
      return null;
    }

    // List the accounts
    final accounts = await listAccounts();

    // Search the one having the same address
    final index =
        accounts.indexWhere((account) => account.address == accountAddress);

    if (index == -1) {
      // No account with same addres found
      return null;
    } else {
      // Account found
      return accounts[index];
    }
  }
}
