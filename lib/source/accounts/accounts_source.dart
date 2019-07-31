import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/sources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'account_helper.dart';

/// Source that must be used when dealing with accounts.
/// TODO: Move the private keys management outside this source
class AccountsSource {
  final KeysSource keysSource;
  final ChainsSource chainsSource;
  final AccountHelper accountHelper;

  AccountsSource({
    @required this.keysSource,
    @required this.chainsSource,
    @required this.accountHelper,
  })  : assert(chainsSource != null),
        assert(keysSource != null),
        assert(accountHelper != null);

  // Store reference to save all the accounts
  final StoreRef<dynamic, dynamic> _accountsStore = StoreRef("accounts");

  // Store reference to save the current account
  final StoreRef<dynamic, dynamic> _currentAccountStore =
      StoreRef("current_account");

  // Current account key used inside the store
  static const _currentAccountKey = "currentAccount";

  // Used to emit new current account values
  final StreamController<Account> _accountController =
      StreamController.broadcast();

  /// Returns the reference to the database of the accounts
  Future<Database> _getDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String dbPath = "accounts.db";

    DatabaseFactory dbFactory = createDatabaseFactoryIo(rootPath: folder.path);
    return await dbFactory.openDatabase(dbPath, version: 1);
  }

  /// Creates a new account based on the given [privateKey] bytes and for
  /// the given [chain]. After creating it, it stores the private key into
  /// the secure storage and the address and chain relation into the
  /// preferences for later retrieval.
  Future<Account> _saveAccount(Account account, ChainInfo chain) async {
    // Save the account
    final database = await _getDatabase();

    // Store the data
    await _accountsStore.record(account.bech32Address).put(
          database,
          account.toJson(),
          merge: true,
        );

    // Return the account after storing
    return account;
  }

  /// Generates and stores an account associated to the given [mnemonic] for
  /// the given [chain].
  /// Returns the account one it has been stored.
  Future<Account> createAndStoreAccount(
    List<String> mnemonic,
    ChainInfo chain,
  ) async {
    // Generate the public key
    final publicKey = await keysSource.derivePublicKeyKey(mnemonic);

    // Generate the account
    final account = await accountHelper.generateAccount(publicKey, chain);

    // Create and save the account
    return await _saveAccount(account, chain);
  }

  /// Converts the given [account] into a new one made for the given [chain].
  Future<Account> convertAndStoreAccount(
    Account account,
    ChainInfo chain,
  ) async {
    // Generate a new account
    final newAccount = await accountHelper.generateAccount(
      account.publicKey,
      chain,
    );

    // Save the new account
    return await _saveAccount(newAccount, chain);
  }

  /// Allows to set the given [account] as the currently used account.
  Future<void> saveAccountAsCurrent(Account account) async {
    // Get the database
    final database = await _getDatabase();

    // Store the data
    await _currentAccountStore.record(_currentAccountKey).put(
          database,
          account == null ? null : account.toJson(),
        );

    _accountController.add(account);
  }

  /// Returns the list of all the accounts securely stored into the device.
  Future<List<Account>> listAccounts() async {
    // Get the database
    final database = await _getDatabase();

    // List all the accounts
    final records = await _accountsStore.find(database);

    // Return the accounts list
    return records.map((item) => Account.fromJson(item.value)).toList();
  }

  /// Returns the current account, or null if no account could be found.
  Future<Account> getCurrentAccount() async {
    // Get the database
    final database = await _getDatabase();

    // Read the data
    final accountSnap =
        await _currentAccountStore.record(_currentAccountKey).get(database);

    // If the current account is null, return null
    return accountSnap == null ? null : Account.fromJson(accountSnap);
  }

  /// Returns a stream that emits the values of the current account as
  /// soon as it changes.
  Stream<Account> getCurrentAccountStream() {
    return _accountController.stream;
  }

  /// Allows to logout setting the current account as null.
  Future<void> logout() async {
    return saveAccountAsCurrent(null);
  }
}
