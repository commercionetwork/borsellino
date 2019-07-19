import 'package:borsellino/dependency_injection/injector.dart';
import 'package:borsellino/pages/home/components/home_app_bar.dart';
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
      appBar: homeAppBar(
        controller: _tabController,
        onPressed: () {
          accountsRepository.logout().then((_) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              SplashScreenPage.routeName,
              (_) => false,
            );
          });
        },
      ),
      body: homeBody(_tabController),
    );
  }
}
