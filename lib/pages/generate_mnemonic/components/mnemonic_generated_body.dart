import 'package:borsellino/pages/pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'word_item.dart';

/// Body used inside the GenerateMnemonicPage when the mnemonic
/// has been successfully generated and should be displayed.
class MnemonicGeneratedBody extends StatelessWidget {
  final List<String> mnemonic;

  MnemonicGeneratedBody(this.mnemonic);

  /// Allows to navigate to the page where the user is asked some random
  /// mnemonic words to make sure he has written them down
  void _goToMnemonicVerificationPage(BuildContext context) {
    if (kReleaseMode) {
      Navigator.pushNamed(
        context,
        ConfirmMnemonicPage.routeName,
        arguments: VerifyMnemonicArguments(mnemonic),
      );
    } else {
      // If in debug, skip the mnemonic confirmation
      Navigator.pushNamed(
        context,
        ChainSelectionPage.routeName,
        arguments: ChainSelectionArguments(mnemonic: mnemonic),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Here is your mnemonic code."),
            Text(
                "Please write it on a piece of paper and then press \"Continue\""),
            SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              padding: EdgeInsets.all(8),
              child: GridView.count(
                childAspectRatio: 1.75,
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: mnemonic
                    .asMap()
                    .map(
                        (index, word) => MapEntry(index, WordItem(index, word)))
                    .values
                    .toList(),
              ),
            ),
            SizedBox(height: 16),
            RaisedButton(
              child: Text("Continue"),
              onPressed: () => _goToMnemonicVerificationPage(context),
            )
          ],
        ),
      ),
    );
  }
}
