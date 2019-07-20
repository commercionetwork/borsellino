import 'package:borsellino/blocprov/blocproviders.dart';
import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/pages/home/components/home_body.dart';
import 'package:borsellino/pages/home/components/home_tabs.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:borsellino/repository/repositories.dart';
import 'package:borsellino/pages/home/components/navigation_item_builder.dart';
import 'package:flutter/material.dart';

/// Represents the home page of the application
class HomePage extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final AccountsRepository accountsRepository = BorsellinoInjector.get();
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
      walletOverviewWalletProvider(),
      homeBody(_tabController),
      sendCoinsBlocProvider()
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
      appBar: AppBar(
        title: Text(APP_NAME),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addAccount(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              _listAccounts(context);
            },
          ),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _logout(context);
              })
        ],
        bottom: _navBarCurrentIndex == 1
            ? TabBar(
                controller: _tabController,
                tabs: homeTabs,
              )
            : null,
      ),
      body: _children[_navBarCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black54,
        currentIndex: _navBarCurrentIndex,
        items: [
          navBarItem(Icon(Icons.account_box), 'ACCOUNT', context),
          navBarItem(Icon(Icons.desktop_mac), 'VALIDATORS', context),
          navBarItem(Icon(Icons.send), 'SEND', context)
        ],
        onTap: _selectPage,
      ),
    );
  }

  void _logout(BuildContext context) {
    accountsRepository.logout().then((_) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SplashScreenPage.routeName,
        (_) => false,
      );
    });
  }

  void _listAccounts(BuildContext context) {
    accountsRepository.getCurrentAccount().then((account) {
      Navigator.pushNamed(context, AccountSelectionPage.routeName);
    });
  }

  void _addAccount(BuildContext context) {
    AddAccountDialog.show(context);
  }
}
