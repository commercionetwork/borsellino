import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/pages/home/components/home_tabs.dart';
import 'package:flutter/material.dart';

// App bar of the home page
AppBar homeAppBar({
  @required TabController controller,
  @required Function onPressed,
}) {
  return AppBar(
    title: Text(APP_NAME),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: onPressed,
      )
    ],
    bottom: TabBar(
      controller: controller,
      tabs: homeTabs,
    ),
  );
}
