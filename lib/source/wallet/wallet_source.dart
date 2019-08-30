import 'dart:async';
import 'dart:io';

import 'package:borsellino/source/sources.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sacco/sacco.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// Source that must be used when dealing with wallets.
class WalletSource {
  static const DERIVATION_PATH = "m/44'/118'/0'/0/0";

  final KeysSource keysSource;
  final ChainsSource chainsSource;

  WalletSource({
    @required this.keysSource,
    @required this.chainsSource,
  })
      : assert(chainsSource != null),
        assert(keysSource != null);

  // Store reference to save all the wallets
  final StoreRef<dynamic, dynamic> _walletsStore = StoreRef("wallets");

  // Store reference to save the current wallet
  final StoreRef<dynamic, dynamic> _currentWalletStore =
  StoreRef("current_wallet");

  // Current wallet key used inside the store
  static const _currentWalletKey = "currentWallet";

  /// Returns the reference to the database of the wallets
  Future<Database> _getDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String dbPath = "wallets.db";

    DatabaseFactory dbFactory = createDatabaseFactoryIo(rootPath: folder.path);
    return await dbFactory.openDatabase(dbPath, version: 1);
  }

  Future<Wallet> _saveWallet(Wallet wallet, NetworkInfo chain) async {
    // Save the wallet
    final database = await _getDatabase();

    // Store the data
    await _walletsStore.record(wallet.bech32Address).put(
      database,
      wallet.toJson(),
      merge: true,
    );

    // Return the wallet after storing
    await keysSource.saveWalletPrivateKey(
      wallet.bech32Address,
      wallet.privateKey,
    );

    return wallet;
  }

  /// Generates and stores a wallet associated to the given [mnemonic] for
  /// the given [chain].
  /// Returns the wallet one it has been stored.
  Future<Wallet> createAndStoreWallet(List<String> mnemonic,
      NetworkInfo chain,
  ) async {
    final wallet = Wallet.derive(mnemonic, DERIVATION_PATH, chain);

    // Create and save the wallet
    return await _saveWallet(wallet, chain);
  }

  /// Converts the given [wallet] into a new one made for the given [chain].
  Future<Wallet> convertAndStoreWallet(Wallet wallet,
      NetworkInfo chain,) async {
    // Generate a new wallet
    final newWallet = Wallet.convert(wallet, chain);

    // Save the new wallet
    return await _saveWallet(newWallet, chain);
  }

  /// Allows to set the given [wallet] as the currently used wallet.
  Future<void> saveWalletAsCurrent(Wallet wallet) async {
    // Get the database
    final database = await _getDatabase();

    // Store the data
    await _currentWalletStore.record(_currentWalletKey).put(
      database,
      wallet == null ? null : wallet.toJson(),
    );
  }

  /// Returns the list of all the wallets securely stored into the device.
  Future<List<Wallet>> listWallets() async {
    // Get the database
    final database = await _getDatabase();

    // List all the wallets
    final records = await _walletsStore.find(database);

    // Return the wallets list
    return await Future.wait(records.map((item) async {
      final key = await keysSource.getPrivateKeyFromAddress(item.key);
      return Wallet.fromJson(item.value, key);
    }));
  }

  /// Returns the current wallet, or null if no wallet could be found.
  Future<Wallet> getCurrentWallet() async {
    // Get the database
    final database = await _getDatabase();

    // Read the data
    final walletSnap =
    await _currentWalletStore.record(_currentWalletKey).get(database);

    // If the current wallet is null, return null
    if (walletSnap == null) {
      return null;
    }

    // Get the key
    final key =
    await keysSource.getPrivateKeyFromAddress(walletSnap['bech32_address']);
    return Wallet.fromJson(walletSnap, key);
  }

  /// Allows to logout setting the current wallet as null.
  Future<void> logout() async {
    return saveWalletAsCurrent(null);
  }
}
