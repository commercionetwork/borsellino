import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/models/models.dart';
import 'package:flutter/material.dart';

/// Body that is shown to the user when the list of accounts has been loaded
/// properly and must be visualized
class AccountsLoadedBody extends StatelessWidget {
  final List<Account> accounts;
  final Function callback;

  AccountsLoadedBody({
    @required this.accounts,
    @required this.callback,
  })  : assert(accounts != null),
        assert(callback != null);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        final account = accounts[index];
        return InkWell(
          child: ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: _buildIcon(account),
            title: Text(account.wallet.bech32Address),
          ),
          onTap: () => callback(account),
        );
      },
      separatorBuilder: (context, index) => Divider(height: 0),
    );
  }

  Widget _buildIcon(Account account) {
    return Image.network(
        account.wallet.networkInfo.iconUrl ?? DEFAULT_CHAIN_IMAGE_URL);
  }
}
