import 'package:flutter/material.dart';
import 'ui/add_process_page.dart';
import 'ui/create_user_page.dart';
import 'ui/my_home_page.dart';
import 'ui/drawer_page.dart';
import 'ui/add_account_page.dart';
import 'ui/add_category_page.dart';
import 'ui/settings_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "UbuntuFont",
      ),
      home: CreateUserPage(),
    );
  }
}