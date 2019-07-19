import 'package:borsellino/models/models.dart';
import 'package:flutter/material.dart';

class ChainSelectionBody extends StatefulWidget {
  final List<ChainInfo> chains;

  ChainSelectionBody({
    @required this.chains,
  }) : assert(chains != null);

  @override
  _ChainSelectionBodyState createState() => _ChainSelectionBodyState();
}

class _ChainSelectionBodyState extends State<ChainSelectionBody> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.chains.length,
      itemBuilder: (context, index) {
        final ChainInfo chain = widget.chains[index];

        return InkWell(
          child: ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: _buildIcon(chain),
            title: Text(chain.name),
          ),
          onTap: () => Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(index.toString()))),
        );
      },
      separatorBuilder: (context, index) => Divider(height: 0),
    );
  }

  Widget _buildIcon(ChainInfo chain) {
    return Image.network(
        chain.iconUrl ?? "https://png.pngtree.com/svg/20160401/a381a1569c.png");
  }
}
