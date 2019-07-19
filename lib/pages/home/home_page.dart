import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/pages/home/components/home_body.dart';
import 'package:borsellino/pages/home/components/home_tabs.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:borsellino/repository/repositories.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: homeTabs.length);
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
        bottom: TabBar(
          controller: _tabController,
          tabs: homeTabs,
        ),
      ),
      body: homeBody(_tabController),
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
