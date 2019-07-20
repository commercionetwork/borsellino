import 'dart:async';
import 'dart:typed_data';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/sources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

  final StreamController<Account> accountController = StreamController.broadcast();

  /// Returns a stream that emits the values of the current account as
  /// soon as it changes.
  Stream<Account> getCurrentAccountStream() {
    return accountController.stream;
  }

  /// Creates a new account based on the given [privateKey] bytes and for
  /// the given [chain]. After creating it, it stores the private key into
  /// the secure storage and the address and chain relation into the
  /// preferences for later retrieval.
  Future<Account> _createAndSaveAccount(
    Uint8List privateKey,
    ChainInfo chain,
  ) async {
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

    return account;
  }

  /// Generates and stores an account associated to the
  /// given [mnemonic] for the given [chain].
  /// Returns the account one it has been stored.
  Future<Account> createAndStoreAccount(
    List<String> mnemonic,
    ChainInfo chain,
  ) async {
    // Generate the private key
    final privateKey = await accountHelper.generatePrivateKey(mnemonic);

    // Create and save the account
    return await _createAndSaveAccount(privateKey, chain);
  }

  /// Converts the given [account] into a new one made for the given [chain].
  Future<Account> convertAndStoreAccount(
    Account account,
    ChainInfo chain,
  ) async {
    // Get the existing private key
    final privateKey = await secureStorage.read(key: account.address);
    final privateKeyBytes = HEX.decode(privateKey);

    // Generate a new account and save it
    return await _createAndSaveAccount(privateKeyBytes, chain);
  }

  /// Allows to set the given [account] as the currently used account.
  Future<void> saveAccountAsCurrent(Account account) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_currentAccountKey, account.address);
    accountController.add(account);
  }

  /// Returns the list of all the accounts securely stored into the device.
  Future<List<Account>> listAccounts() async {
    // List all the private keys
    final privateKeys = await secureStorage.readAll();

    // Get a reference to the SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Define the accounts
    final List<Account> accounts = List();

    for (var i = 0; i < privateKeys.entries.length; i++) {
      final entry = privateKeys.entries.elementAt(i);
      final address = entry.key;
      final privateKey = entry.value;
      print("Reading private key entry $address - $privateKey");

      // Get the chain id from the preferences
      final chain = prefs.getString(address);
      print("Retrieved chain with id $chain");

      if (chain != null) {
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
      }
    }

    // Return the accounts list
    return accounts;
  }

  /// Returns the current account, or null if no account could be found.
  Future<Account> getCurrentAccount() async {
    // Get the current account address
    final prefs = await SharedPreferences.getInstance();
    final accountAddress = prefs.getString(_currentAccountKey);

    if (accountAddress == null) {
      print("No account set into the preferences");
      // No current account set, return null
      return null;
    }

    // List the accounts
    final accounts = await listAccounts();

    // Search the one having the same address
    final validAccounts =
        accounts.where((account) => account.address == accountAddress).toList();

    if (validAccounts.isEmpty) {
      print("No account matching the latest one found");
      // No account with same address found
      return null;
    } else {
      // Account found
      return validAccounts[0];
    }
  }

  /// Returns the private key associated with the given [account].
  Future<Uint8List> getPrivateKey(Account account) async {
    final privateKey = await secureStorage.read(key: account.address);
    return HEX.decode(privateKey);
  }

  /// Allows to logout setting the current account as null.
  Future<void> logout() async {
    // Set the current account as null
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_currentAccountKey, null);
  }
}
