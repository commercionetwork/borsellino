import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:borsellino/models/models.dart';
import 'package:borsellino/pages/home/components/home_app_bar.dart';
import 'package:borsellino/pages/home/components/home_body.dart';
import 'package:borsellino/pages/home/components/home_tabs.dart';
import 'package:borsellino/pages/home/components/navigation_item_builder.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:borsellino/pages/wallet_overview/wallet_overview_page.dart';
import 'package:flutter/material.dart';


/// Represents the home page of the application
class HomePage extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  int _navBarCurrentIndex = 0;
  List<Widget> _children;

  void _selectPage(int index) {
    setState(() {
      _navBarCurrentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: homeTabs.length);
    _children = [
      WalletOverviewPage(),
      homeBody(_tabController)
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(_tabController, _navBarCurrentIndex),
      body: _children[_navBarCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black54,
        currentIndex: _navBarCurrentIndex,
        items: [
          navBarItem(Icon(Icons.account_box), 'ACCOUNT', context),
          navBarItem(Icon(Icons.desktop_mac), 'VALIDATORS', context)
        ],
        onTap: _selectPage,
      ),
    );
  }
}
