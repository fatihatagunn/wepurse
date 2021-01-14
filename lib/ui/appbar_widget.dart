import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  String titleVariable;

  AppBarWidget() {
    this.titleVariable = "wepurse";
  }

  AppBarWidget.withTitle(String titleName) {
    this.titleVariable = titleName;
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      shadowColor: Colors.indigo,
      backgroundColor: Colors.indigo,
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        titleVariable,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }
}
