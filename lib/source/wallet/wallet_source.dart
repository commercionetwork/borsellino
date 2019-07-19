import 'dart:convert';

import 'package:borsellino/models/models.dart';
import 'package:borsellino/models/wallet/coin.dart';
import 'package:borsellino/source/sources.dart';
import 'package:borsellino/source/utils.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// Class that must be used when dealing with wallet information.
class WalletSource {
  // Endpoints
  static const _walletEndpoint = "auth/accounts";

  final http.Client httpClient;
  final AccountsSource accountsSource;

  WalletSource({
    @required this.httpClient,
    @required this.accountsSource,
  })  : assert(httpClient != null),
        assert(accountsSource != null);

  /// Allows to return the current wallet instance
  Future<Wallet> getCurrentWallet() async {
    // Get the current account
    final account = await accountsSource.getCurrentAccount();

    // Get the chain info
    final chain = account.chain;

    // Build the wallet api url
    final apiUrl = "${chain.lcdUrl}/$_walletEndpoint/${account.address}";

    // Get the server response
    final response = await httpClient.get(apiUrl);
    checkResponse(response);

    // Parse the data
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final value = json["value"] as Map<String, dynamic>;

    // Get the coins
    final coins = ((value["coins"] as List) ?? List()).map((coinMap) {
      return Coin(amount: coinMap["amount"], denom: coinMap["denom"]);
    }).toList();

    // Build the wallet
    return Wallet(
      account: account,
      accountNumber: value["account_number"],
      sequence: value["sequence"],
      coins: coins,
    );
  }
}
