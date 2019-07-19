import 'package:borsellino/pages/home/components/home_app_bar.dart';
import 'package:borsellino/pages/home/components/home_body.dart';
import 'package:borsellino/pages/home/components/home_tabs.dart';
import 'package:flutter/material.dart';


/// Represents the home page of the application
class HomePage extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

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
      appBar: homeAppBar(_tabController),
      body: homeBody(_tabController),
    );
  }
}
