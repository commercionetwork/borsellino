import 'package:flutter/material.dart';

/// Represents a single word that is part of the mnemonic
class WordItem extends StatelessWidget {
  final int index;
  final String word;

  WordItem(this.index, this.word);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Theme.of(context).primaryColorLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            (index + 1).toString(),
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            word,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
