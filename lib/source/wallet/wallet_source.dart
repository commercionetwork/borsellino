import 'dart:convert';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/transactions/std_coin.dart';
import 'package:borsellino/source/sources.dart';
import 'package:borsellino/source/utils.dart';
import 'package:borsellino/source/wallet/models/account_data.dart';
import 'package:borsellino/source/wallet/wallet_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:sprintf/sprintf.dart';

/// Class that must be used when dealing with wallet information.
class WalletSource {
  final http.Client httpClient;
  final AccountsSource accountsSource;

  WalletSource({
    @required this.httpClient,
    @required this.accountsSource,
  })  : assert(httpClient != null),
        assert(accountsSource != null);

  /// Reads the account endpoint and retrieves data from it.
  Future<AccountData> _getAccountData(Account account) async {
    print("Getting account data");

    // Build the wallet api url
    final endpoint = sprintf(WalletEndpoints.ACCOUNT, [account.address]);

    // Build the API URL
    final apiUrl = "${account.chain.lcdUrl}$endpoint";

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
  Future<List<DelegationData>> _getDelegationsData(Account account) async {
    print("Getting delegators data");

    // Get the endpoint
    final endpoint = sprintf(WalletEndpoints.DELEGATIONS, [account.address]);

    // Build the API URL
    final apiUrl = "${account.chain.lcdUrl}$endpoint";

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
    Account account,
  ) async {
    print("Getting delegations data");

    // Get the endpoint
    final endpoint = sprintf(
      WalletEndpoints.UNBONDING_DELEGATIONS,
      [account.address],
    );

    // Build the API URL
    final apiUrl = "${account.chain.lcdUrl}$endpoint";

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

  Future<List<StdCoin>> _getRewards(Account account) async {
    print("Getting rewards data");

    // Get the endpoint
    final endpoint = sprintf(WalletEndpoints.REWARDS, [account.address]);

    // Build the API URL
    final apiUrl = "${account.chain.lcdUrl}$endpoint";

    // Get the response
    final response = await httpClient.get(apiUrl);
    checkResponse(response);

    // Parse the data
    final json = jsonDecode(response.body) as Map;

    // Read the data with fallback if null
    var rewards = [];
    if (json?.containsKey("total") == true) {
      rewards = (json["total"] as List);
    }

    return rewards.map((object) => StdCoin.fromJson(object)).toList();
  }

  /// Allows to return the current wallet instance
  Future<Wallet> getCurrentWallet() async {
    // Get the current account
    final account = await accountsSource.getCurrentAccount();
    print("Getting data for account with address ${account.address}");

    // Get all the data
    final accountData = await _getAccountData(account);
    print("Account data: $accountData");

    final delegations = await _getDelegationsData(account);
    print("Delegations: $delegations");

    final unbondingDelegations = await _getUnbondingDelegations(account);
    print("Unbonding: $unbondingDelegations");

    final rewards = await _getRewards(account);
    print("Rewards: $rewards");

    // Build the wallet
    return Wallet(
      account: account,
      accountNumber: accountData.accountNumber,
      sequence: accountData.sequence,
      availableCoins: accountData.coins,
      delegatedCoins: delegations,
      unbondingDelegations: unbondingDelegations,
      rewards: rewards,
    );
  }
}
