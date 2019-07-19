import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/pages/home/components/home_tabs.dart';
import 'package:flutter/material.dart';

// App bar of the home page
AppBar homeAppBar(TabController controller, int pageIndex) {
  return AppBar(
    title: Text(APP_NAME),
    bottom: pageIndex == 1 ? TabBar(
      controller: controller,
      tabs: homeTabs,
    ) : null
  );
}