import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/source/account/account_endpoints.dart';
import 'package:borsellino/source/sources.dart';
import 'package:borsellino/source/utils.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sacco/sacco.dart';
import 'package:sacco/wallet.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sprintf/sprintf.dart';

/// Class that must be used when dealing with wallet information.
class AccountSource {
  final http.Client httpClient;
  final WalletSource walletSource;

  AccountSource({
    @required this.httpClient,
    @required this.walletSource,
  })  : assert(httpClient != null),
        assert(walletSource != null);

  // Store reference to save all the wallets
  final StoreRef<String, Account> _accountsStore = StoreRef("accounts");

  // Used to emit new current wallet values
  final StreamController<Account> _accountController =
      StreamController.broadcast();

  /// Returns the reference to the database of the wallets
  Future<Database> _getDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String dbPath = "accounts.db";

    DatabaseFactory dbFactory = createDatabaseFactoryIo(rootPath: folder.path);
    return await dbFactory.openDatabase(dbPath, version: 1);
  }

  Future<Account> _convertWalletToAccountAndStore(Wallet wallet) async {
    // Try search the database for the related account
    final database = await _getDatabase();
    final accountSnap =
        await _accountsStore.record(wallet.bech32Address).get(database);
    if (accountSnap != null) {
      return accountSnap;
    }

    // Get all the data
    final accountData = await _getAccountData(wallet);
    print("Account data: $accountData");

    final delegations = await _getDelegationsData(wallet);
    print("Delegations: $delegations");

    final unbondingDelegations = await _getUnbondingDelegations(wallet);
    print("Unbonding: $unbondingDelegations");

    final rewards = await _getRewards(wallet);
    print("Rewards: $rewards");

    // Build the wallet
    final account = Account(
      wallet: wallet,
      availableCoins: accountData.coins,
      delegatedCoins: delegations,
      unbondingDelegations: unbondingDelegations,
      rewards: rewards,
    );

    // Save the account
    _accountsStore.record(wallet.bech32Address).put(database, account);

    return account;
  }

  /// Reads the account endpoint and retrieves data from it.
  Future<AccountData> _getAccountData(Wallet wallet) async {
    print("Getting account data");

    // Build the wallet api url
    final endpoint = sprintf(AccountEndpoints.ACCOUNT, [wallet.bech32Address]);

    // Build the API URL
    final apiUrl = "${wallet.networkInfo.lcdUrl}$endpoint";

    // Get the server response
    final response = await httpClient.get(apiUrl);
    checkResponse(response);

    // Parse the data
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final value = json["value"] as Map<String, dynamic>;

    // Get the coins
    final coins = ((value["coins"] as List) ?? List())
        .map((coinMap) => StdCoin.fromJson(coinMap))
        .toList();

    return AccountData(
      accountNumber: value["account_number"],
      sequence: value["sequence"],
      coins: coins,
    );
  }

  /// Retrieves the data of the delegations that an account has made
  Future<List<DelegationData>> _getDelegationsData(Wallet wallet) async {
    print("Getting delegators data");

    // Get the endpoint
    final endpoint =
        sprintf(AccountEndpoints.DELEGATIONS, [wallet.bech32Address]);

    // Build the API URL
    final apiUrl = "${wallet.networkInfo.lcdUrl}$endpoint";

    // Get the response
    final response = await httpClient.get(apiUrl);
    checkResponse(response);

    // Parse the data
    final json = (jsonDecode(response.body) as List) ?? List();
    return json.map((object) {
      return DelegationData(
        validator: object["validator_address"],
        shares: double.parse(object["shares"]),
      );
    }).toList();
  }

  /// Retrieves all the unbonding delegations
  Future<List<UnbondingDelegation>> _getUnbondingDelegations(
    Wallet wallet,
  ) async {
    print("Getting unbonding data");

    // Get the endpoint
    final endpoint =
        sprintf(AccountEndpoints.UNBONDING_DELEGATIONS, [wallet.bech32Address]);

    // Build the API URL
    final apiUrl = "${wallet.networkInfo.lcdUrl}$endpoint";

    // Get the response
    final response = await httpClient.get(apiUrl);
    checkResponse(response);

    // Parse the data
    final json = (jsonDecode(response.body) as List) ?? List();
    return json.map((object) {
      return UnbondingDelegation(
        balance: double.parse(object["balance"]),
        validator: object["validator_address"],
      );
    }).toList();
  }

  Future<List<StdCoin>> _getRewards(Wallet wallet) async {
    print("Getting rewards data");

    // Get the endpoint
    final endpoint = sprintf(AccountEndpoints.REWARDS, [wallet.bech32Address]);

    // Build the API URL
    final apiUrl = "${wallet.networkInfo.lcdUrl}$endpoint";

    // Get the response
    final response = await httpClient.get(apiUrl);
    checkResponse(response);

    // Parse the data
    var rewards = [];
    final json = jsonDecode(response.body);

    // Sometimes the rewards are a map...
    if (json is Map) {
      // Read the data with fallback if null
      if (json?.containsKey("total") == true) {
        rewards = (json["total"] as List);
      }
    }

    // ...some other times the rewards are a list
    if (json is List) {
      rewards = json;
    }

    return rewards.map((object) => StdCoin.fromJson(object)).toList();
  }

  /// Allows to return the current wallet instance
  Future<Account> getCurrentAccount() async {
    // Get the current account
    final wallet = await walletSource.getCurrentWallet();
    if (wallet == null) {
      return null;
    }

    print("Getting data for account with address ${wallet.bech32Address}");

    return _convertWalletToAccountAndStore(wallet);
  }

  /// Allows to set the given [wallet] as the currently used wallet.
  Future<Account> saveAccountAsCurrent(Account account) async {
    await walletSource.saveWalletAsCurrent(account.wallet);
    _accountController.add(account);
    return account;
  }

  /// Returns the list of all the wallets securely stored into the device.
  Future<List<Account>> listAccounts() async {
    final wallets = await walletSource.listWallets();
    return await Future.wait(wallets.map((wallet) async {
      return _convertWalletToAccountAndStore(wallet);
    }));
  }

  /// Returns a stream that emits the values of the current wallet as
  /// soon as it changes.
  Stream<Account> getCurrentAccountStream() {
    return _accountController.stream;
  }

  /// Generates and stores a wallet associated to the given [mnemonic] for
  /// the given [chain].
  /// Returns the wallet one it has been stored.
  Future<Account> createAndStoreAccount(
    List<String> mnemonic,
    NetworkInfo chain,
  ) async {
    final wallet = await walletSource.createAndStoreWallet(mnemonic, chain);
    return await _convertWalletToAccountAndStore(wallet);
  }

  /// Converts the given [account] into a new one made for the given [chain].
  Future<Account> convertAndStoreAccount(
    Account account,
    NetworkInfo chain,
  ) async {
    final newWallet =
        await walletSource.convertAndStoreWallet(account.wallet, chain);
    return await _convertWalletToAccountAndStore(newWallet);
  }

  /// Allows to logout setting the current wallet as null.
  Future<void> logout() async {
    return saveAccountAsCurrent(null);
  }
}
