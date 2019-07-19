import 'package:flutter/material.dart';



BottomNavigationBarItem navBarItem(Icon icon, String title, BuildContext context){
    return BottomNavigationBarItem(
      backgroundColor: Theme.of(context).textSelectionColor,
      icon: icon,
      title: Text(title),
    );
}