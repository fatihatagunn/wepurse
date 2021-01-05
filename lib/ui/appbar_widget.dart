import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      shadowColor: Colors.pinkAccent,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.pinkAccent),

      title: Text("wepurse", style: TextStyle(color: Colors.pinkAccent),),
      centerTitle: true,

    );
  }
}